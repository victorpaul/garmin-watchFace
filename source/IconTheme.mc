using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

// Our icon SVGs have a fill color baked in at compile time, so contrast
// against the user's chosen background can't be done with runtime tinting -
// every icon ships as a dark-fill and a light-fill drawable, and callers
// pick between them through getIcon().
module IconTheme {

    function isBackgroundLight() {
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        if (bgColor == null) {
            bgColor = 0x000000;
        }

        var r = (bgColor >> 16) & 0xFF;
        var g = (bgColor >> 8) & 0xFF;
        var b = bgColor & 0xFF;
        var luminance = (r * 0.299) + (g * 0.587) + (b * 0.114);

        return luminance > 127;
    }

    function getIcon(darkIconId, lightIconId) {
        return WatchUi.loadResource(isBackgroundLight() ? darkIconId : lightIconId);
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
