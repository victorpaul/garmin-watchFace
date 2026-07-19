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
- `monkey.jungle` — points at `manifest.xml`; nothing else customized. The
  SDK compiles `source/**/*.mc` recursively, so subdirectories (e.g.
  `source/utils/`) need no jungle changes to be picked up.
- `source/*.mc` — app/view/helper/device-dispatch code.
- `source/utils/*.mc` — see "Per-feature util classes" below.
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

Unit tests (`source/tests*.mc`) build and run via `./run-tests.sh [device]`
(defaults to `fenix7`) or `./run-tests-all.sh` (loops every device in
`manifest.xml`, ~135 devices — takes a while). Both scripts compile with `-t`,
launch/reuse a running simulator, and grep `monkeydo`'s summary line for
`PASSED` (its process exit code isn't reliable). The Connect IQ CLI has no
built-in "run against all devices" mode — Eclipse's equivalent view just loops
`monkeydo` per device internally too, so this is the standard approach.

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

Every self-contained piece of watch-face behavior — not just the stats shown
in a numbered slot, but background behaviors too — owns a small,
single-purpose class in its own file under `source/utils/`: `battery.mc`,
`steps.mc`, `floors.mc`, `messages.mc`, `hr.mc`, `weather.mc`,
`bluetooth.mc`, `beep.mc`. Two shapes of util, depending on what the feature
does:

- **Displayable stats** (battery, steps, floors, messages, hr, weather,
  bluetooth) — shown in one of the numbered `WhatToShowAt*` slots:
  - A plain-value getter (e.g. `battery.getBatteryText(...)`,
    `hr.getHRNumber(debug)`) that knows how to read the underlying Toybox API
    (`ActivityMonitor`, `System.getSystemStats()`,
    `Weather.getCurrentConditions()`, etc.) and format it, including the
    `debug` placeholder value used by the simulator/tests.
  - A `draw*Icon(dc, x, y, font, align, debug)` method that combines that
    value with its themed icon via `IconTheme.drawIconWithText(...)` (or,
    for icon-only stats like battery/bluetooth, via `IconTheme.getIcon(...)`
    directly).
- **Background behaviors** (beep) — not tied to a settings slot, just
  something the view calls unconditionally every `onUpdate()`. No
  `draw*Icon`/icon involved; the util owns whatever state it needs across
  calls itself (e.g. `beep.lastPhoneConnectionState`) instead of the view
  holding it, so the behavior stays fully self-contained in its own file.

Both shapes share the same capability-check convention: if a getter reads a
Toybox symbol that isn't guaranteed to exist on every device (a whole module
like `Weather` or `Attention`, or an optional field like
`ActivityMonitor.Info.floorsClimbed` on devices without an altimeter), check
`has` **once in the util's own `initialize()`** and cache the result in a
bool (e.g. `weather.hasWeather`, `floors.hasFloorsClimbed`,
`beep.hasTone`/`beep.hasVibrate`), then branch on that cached bool wherever
the util needs it. Device capability doesn't change at runtime, so
re-checking `has` on every call is redundant — this mirrors
`helper.initializeDevice()` caching `deviceType`/`isOledDisplay` once.
Referencing a completely missing module (not just a missing method) can
itself throw `Symbol Not Found` even inside a `has` check, so module-level
checks need the two-step form: `Toybox has :Weather && Weather has :getCurrentConditions`.

`source/helper.mc` (the `helper` class, instantiated once per view as `uiH`)
owns one instance of every util (`weatherService`, `batteryService`,
`stepsService`, `floorsService`, `messagesService`, `hrService`,
`bluetoothService`, `beepService`), created in `initialize()` — this applies
to background behaviors too, not just displayable stats. For displayable
stats, the big per-layout switch statements — `drawTopFA()`
(top-center/top-left slot) and `drawBottomLineByOption()` (the three
bottom-left rows) — dispatch to `<service>.draw*Icon(...)` for each numbered
option; `drawTopRight`/`drawTopRightFont` and the individual
`draw_<device>()` functions in `phoneBatteryIQView.mc` call into `helper` the
same way. For background behaviors, the view just calls the service method
directly (e.g. `uiH.beepService.checkPhoneConnectionAndBeep()` from
`onUpdate()`) — no switch/slot involved.

**When adding a new feature util**:

1. Create `source/utils/<feature>.mc` with a class matching the filename
   (e.g. `class beep` in `beep.mc`) — no jungle changes needed, `source/**/*.mc`
   is picked up recursively.
2. Pick the shape: displayable stat (getter + `draw*Icon`) or background
   behavior (a method the view calls unconditionally). Cache any `has`
   capability checks in the util's own `initialize()` per the convention
   above.
3. Instantiate it once in `helper.initialize()` as `<feature>Service`.
4. Wire it in:
   - Displayable stat: add a case to the relevant switch(es) in `helper.mc`
     (`drawTopFA`/`drawBottomLineByOption`/etc.), then register the option in
     `resources/settings/settings.xml` + `resources/strings/strings.xml` (add
     the list value under every `WhatToShowAt*` setting it should appear in).
   - Background behavior: call `uiH.<feature>Service.<method>()` directly
     from wherever in `phoneBatteryIQView.mc` it needs to run (e.g.
     `onUpdate()`), no settings wiring required unless the behavior itself is
     user-toggleable (in which case add a `type="boolean"` property the same
     way `BeepOnPhoneDisconnect` works for `beep.mc`).
5. Run `./run-tests.sh [device]` (or `./run-tests-all.sh` for the full
   device sweep) to confirm nothing crashes, especially on devices missing
   whatever Toybox module/field the new util reads.

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
