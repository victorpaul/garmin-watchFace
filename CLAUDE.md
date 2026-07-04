# Garmin Watch Face — phoneBatteryIQ

A Garmin Connect IQ watch face written in Monkey C. Shows time plus a
configurable set of stats (steps, floors, calories, battery, heart rate,
weather, messages, phone connection) across a wide range of Garmin devices,
each with its own hand-tuned layout function.

App name: `phoneBatteryIQApp` (`source/phoneBatteryIQApp.mc`), entry view
`phoneBatteryIQView` (`source/phoneBatteryIQView.mc`).

## Project layout

- `manifest.xml` — declares the app id, version, and the full list of
  supported device product ids. Marked "generated" by the SDK tooling; treat
  edits with care (adding a device here doesn't add simulator run configs).
- `monkey.jungle` — points at `manifest.xml`; nothing else customized.
- `source/*.mc` — see "Per-feature util classes" below.
- `resources/` (+ `resources-<lang>/` per-locale copies) — `drawables/`,
  `fonts/`, `layouts/`, `settings/`, `strings/`.
- `.vscode/launch.json` — one simulator run config per device. When a new
  device is added to `manifest.xml`, add a matching entry here (check
  `~/Library/Application Support/Garmin/ConnectIQ/Devices/<device>/simulator.json`
  for its real screen width/height/shape before wiring up a new
  `DeviceType`/`draw_*` pair in `DeviceService.mc` / `phoneBatteryIQView.mc`).

## Build / verify

The VS Code Monkey C extension (`garmin.monkey-c`) drives builds through
`.vscode/launch.json`; it reads the signing key from the global VS Code
setting `monkeyC.developerKeyPath` and the active SDK from
`~/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg` — neither
lives in this repo. To compile from the command line (e.g. to sanity-check a
change without the IDE), invoke the SDK's `monkeyc` directly against
`monkey.jungle` with any signing key:

```
monkeyc -f monkey.jungle -d <device> -o out.prg -y <path-to-key.der> -w
```

Unit tests (`source/tests*.mc`) currently fail to *build* for an unrelated,
pre-existing reason: `testsHelper.mc` passes bare method references
(e.g. `uiH.fontMedium`) where the compiler wants a `Lang.Method` object. This
predates the icon-refactor work described below — don't assume it's caused by
whatever you're currently changing.

## Icon theming: dark/light SVG pairs + `IconTheme`

Feature icons are Material-Symbols-style SVGs with a **fill color baked in at
export time** (filename suffix `_1F1F1F_` = dark fill, `_FFFFFF_` = light
fill). Connect IQ bitmaps can't be runtime-tinted the way text can via
`dc.setColor`, so there is no single icon that looks right on both the
`BackgroundColor` choices users can pick in settings (light or dark).

The fix used throughout this project: **every icon ships as two files**, one
dark-fill and one light-fill, both registered in `resources/drawables/drawables.xml`
with `_dark` / `_light` suffixed ids (e.g. `mail_dark` / `mail_light`,
`battery_3_dark` / `battery_3_light`). `source/IconTheme.mc` is the module
that picks between them at draw time:

- `IconTheme.isBackgroundLight()` — reads the `BackgroundColor` property and
  computes luminance.
- `IconTheme.getIcon(darkIconId, lightIconId)` — loads whichever variant
  contrasts against the current background.
- `IconTheme.drawIconWithText(dc, x, y, font, text, align, darkIconId, lightIconId)`
  — the shared "number then icon" layout helper used by steps/floors/
  messages/hr/weather. `align` mirrors `dc.drawText`'s justification
  (`TEXT_JUSTIFY_LEFT/RIGHT/CENTER`) so the whole text+icon group anchors to
  `x` the same way a plain text draw would.

**When adding a new icon**: export both a dark-fill and a light-fill SVG
(same filename otherwise, `1F1F1F` vs `FFFFFF` suffix — see any existing pair
in `resources/drawables/*/` for the exact naming pattern), add both to
`drawables.xml` as `<name>_dark` / `<name>_light`, and load them through
`IconTheme.getIcon(...)` or `IconTheme.drawIconWithText(...)` — never
`WatchUi.loadResource()` directly on a single hardcoded id, or the icon will
disappear against one of the two background choices.

## Per-feature util classes

Each stat the watch face can show owns a small, single-purpose class in its
own file: `battery.mc`, `steps.mc`, `floors.mc`, `messages.mc`, `hr.mc`,
`weather.mc`, `bluetooth.mc`. The convention:

- A plain-value getter (e.g. `battery.getBatteryText(...)`,
  `hr.getHRNumber(debug)`) that knows how to read the underlying Toybox API
  (`ActivityMonitor`, `System.getSystemStats()`, `Weather.getCurrentConditions()`,
  etc.) and format it, including the `debug` placeholder value used by the
  simulator/tests.
- A `draw*Icon(dc, x, y, font, align, debug)` method that combines that value
  with its themed icon via `IconTheme.drawIconWithText(...)` (or, for
  icon-only stats like battery/bluetooth, via `IconTheme.getIcon(...)`
  directly).

`source/helper.mc` (the `helper` class, instantiated once per view as `uiH`)
owns one instance of each service (`weatherService`, `batteryService`,
`stepsService`, `floorsService`, `messagesService`, `hrService`,
`bluetoothService`), created in `initialize()`. The big per-layout switch
statements — `drawTopFA()` (top-center/top-left slot) and
`drawBottomLineByOption()` (the three bottom-left rows) — dispatch to
`<service>.draw*Icon(...)` for each numbered option. `drawTopRight`/
`drawTopRightFont` and the individual `draw_<device>()` functions in
`phoneBatteryIQView.mc` call into `helper` the same way.

**When adding a new displayable stat**: create `source/<feature>.mc` following
this pattern, instantiate it in `helper.initialize()`, add a case to the
relevant switch(es) in `helper.mc`, and register the option in
`resources/settings/settings.xml` + `resources/strings/strings.xml` (add the
list value under every `WhatToShowAt*` setting it should appear in).

## Settings wiring

Three files stay in sync for every user-configurable option:

- `resources/settings/properties.xml` — property id, type, default value.
- `resources/settings/settings.xml` — the on-device settings UI: list options
  (numbered `listEntry` values matching the `case` numbers in `helper.mc`'s
  switches) or a `type="boolean"` toggle for on/off features.
- `resources/strings/strings.xml` (+ per-locale copies under
  `resources-<lang>/strings/strings.xml`) — the display strings referenced by
  `settings.xml`. The build fails if a locale file references a string id
  that doesn't exist in the base `resources/strings/strings.xml` — when
  removing a string, remove it from every locale file, not just the default.
  Renaming a string's meaning without removing the id is safe to leave
  untranslated in other locales.

## Multi-device layouts

`DeviceService.mc` maps `(screenWidth, screenHeight, screenShape)` to a
`DeviceType` constant; `phoneBatteryIQView.mc`'s `onUpdate()` switches on that
to call one `draw_<device>(dc)` function per device family. Each function
hand-places elements with hardcoded pixel offsets tuned for that screen — there
is no shared layout engine, so a new device usually means both a new
`DeviceType` case and a new `draw_*` function (or reuse an existing one if
the resolution bucket already matches).
