using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class battery {

    function initialize() {
    }

    function getBatteryText(shortFormat, debug) {
        if (shortFormat) {
            if (debug) {
                return "100%";
            }
            return Lang.format("$1$$2$", [System.getSystemStats().battery.format("%d") + "%", ""]);
        }
        if (debug) {
            return "100% battery";
        }
        return Lang.format("$1$ $2$", [System.getSystemStats().battery.format("%d") + "%", WatchUi.loadResource(Rez.Strings.BatteryLong)]);
    }

    // Draws the battery level as a themed SVG icon (no text). align controls
    // which edge of the icon lands on x, mirroring dc.drawText's justification:
    // TEXT_JUSTIFY_LEFT (default) draws from x, TEXT_JUSTIFY_RIGHT ends at x,
    // TEXT_JUSTIFY_CENTER centers on x.
    function drawBatteryIcon(dc, x, y, align) {
        var iconIds = getBatteryIconIds();
        var icon = IconTheme.getIcon(iconIds[0], iconIds[1]);

        var iconX = x;
        if (align == Graphics.TEXT_JUSTIFY_RIGHT) {
            iconX = x - icon.getWidth();
        } else if (align == Graphics.TEXT_JUSTIFY_CENTER) {
            iconX = x - (icon.getWidth() / 2);
        }

        dc.drawBitmap(iconX, y, icon);
    }

    function getBatteryIconIds() {
        var level = System.getSystemStats().battery;
        return mapLevelToIconIds(level);
    }

    // 7 icon steps (battery_0 emptiest .. battery_6 fullest) over 0-100%.
    function mapLevelToIconIds(level) {
        if (level >= 93) {
            return [Rez.Drawables.battery_6_dark, Rez.Drawables.battery_6_light];
        } else if (level >= 79) {
            return [Rez.Drawables.battery_5_dark, Rez.Drawables.battery_5_light];
        } else if (level >= 65) {
            return [Rez.Drawables.battery_4_dark, Rez.Drawables.battery_4_light];
        } else if (level >= 51) {
            return [Rez.Drawables.battery_3_dark, Rez.Drawables.battery_3_light];
        } else if (level >= 37) {
            return [Rez.Drawables.battery_2_dark, Rez.Drawables.battery_2_light];
        } else if (level >= 23) {
            return [Rez.Drawables.battery_1_dark, Rez.Drawables.battery_1_light];
        }
        return [Rez.Drawables.battery_0_dark, Rez.Drawables.battery_0_light];
    }
}
