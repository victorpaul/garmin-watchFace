using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

// ColorTheme
//
// Resolves day vs. night colour palette from user properties
// and writes the result back into the two properties that the
// existing helper.setColors(dc) already reads:
//   "BackgroundColor"  and  "ForegroundColor"
//
// This means helper.mc and the bulk of phoneBatteryIQView.mc
// need zero changes for foreground/background colours.
//
// Also exposes two public fields for callers that need extra
// colour information the original code did not handle:
//   .accent   -- arcs, ticks, battery bar, etc.
//   .aodTime  -- the dim colour for AOD time-only layout

class ColorTheme {

    var accent;
    var aodTime;

    function initialize() {
        accent  = Graphics.COLOR_BLUE;
        aodTime = 0x444444;
    }

    // Call once at the very top of onUpdate(), before any drawing.
    function apply() {
        var info = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var hour = info.hour;

        var dayStart = _prop("DayStartHour",  7);
        var dayEnd   = _prop("DayEndHour",   22);

        var fg, bg;
        if (hour >= dayStart && hour < dayEnd) {
            fg     = _prop("DayColorFg",      0xFFFFFF);
            bg     = _prop("DayColorBg",      0x000000);
            accent = _prop("DayColorAccent",  0x00AAFF);
        } else {
            fg     = _prop("NightColorFg",    0xAAAAAA);
            bg     = _prop("NightColorBg",    0x000000);
            accent = _prop("NightColorAccent",0xFF6600);
        }
        aodTime = _prop("AodColorTime", 0x444444);

        // Overwrite the two properties that helper.setColors() reads.
        Application.getApp().setProperty("BackgroundColor", bg);
        Application.getApp().setProperty("ForegroundColor", fg);
    }

    hidden function _prop(key, fallback) {
        var v = Application.getApp().getProperty(key);
        if (v == null) { return fallback; }
        return v;
    }
}
