using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

// Our icon SVGs have a fill color baked in at compile time, so they can't be
// runtime-tinted like text can - every icon ships as a dark-fill and a
// light-fill drawable, and callers pick between them through getIcon().
// The icon should match the same color as the text it's drawn next to, so
// selection follows ForegroundColor (not BackgroundColor): a dark foreground
// gets the dark-fill icon, a light foreground gets the light-fill icon.
module IconTheme {

    // Some old devices (confirmed: fr920xt/vivoactive_hr, 205x148x3 and
    // 148x205x3) render the icon bitmap's transparent area as an opaque
    // black box instead of staying see-through. A dark-fill icon disappears
    // into that box; the light-fill (white) icon stays visible against it.
    // Screens on that hardware generation set this true to always get the
    // light variant, regardless of ForegroundColor.
    var forceLightIcon = false;

    function isForegroundLight() {
        var fgColor = Application.getApp().getProperty("ForegroundColor");
        if (fgColor == null) {
            fgColor = 0xFFFFFF;
        }

        var r = (fgColor >> 16) & 0xFF;
        var g = (fgColor >> 8) & 0xFF;
        var b = fgColor & 0xFF;
        var luminance = (r * 0.299) + (g * 0.587) + (b * 0.114);

        return luminance > 127;
    }

    function getIcon(darkIconId, lightIconId) {
        if (forceLightIcon) {
            return WatchUi.loadResource(lightIconId);
        }
        return WatchUi.loadResource(isForegroundLight() ? lightIconId : darkIconId);
    }

    // Text + icon combo (number first, icon after), positioned so the whole
    // group lands relative to x the same way dc.drawText's justification
    // would: TEXT_JUSTIFY_LEFT starts the text at x, TEXT_JUSTIFY_RIGHT ends
    // the icon at x, and TEXT_JUSTIFY_CENTER centers the text+icon group on x.
    function drawIconWithText(dc, x, y, font, text, align, darkIconId, lightIconId) {
        var icon = getIcon(darkIconId, lightIconId);
        var gap = 2;
        var textWidth = dc.getTextDimensions(text, font)[0];

        if (align == Graphics.TEXT_JUSTIFY_RIGHT) {
            dc.drawBitmap(x - icon.getWidth(), y, icon);
            dc.drawText(x - icon.getWidth() - gap, y, font, text, Graphics.TEXT_JUSTIFY_RIGHT);
        } else if (align == Graphics.TEXT_JUSTIFY_CENTER) {
            var totalWidth = textWidth + gap + icon.getWidth();
            var startX = x - (totalWidth / 2);
            dc.drawText(startX, y, font, text, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawBitmap(startX + textWidth + gap, y, icon);
        } else {
            dc.drawText(x, y, font, text, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawBitmap(x + textWidth + gap, y, icon);
        }
    }
}
