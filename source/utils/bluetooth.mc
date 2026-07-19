using Toybox.System;
using Toybox.Application;

class bluetooth {

    function initialize() {
    }

    function isEnabled() {
        var enabled = Application.getApp().getProperty("BTCOnnection");
        if (enabled == null) {
            enabled = false;
        }
        return enabled;
    }

    // Draws the phone-connected icon centered on (x, y), matching the old
    // font-glyph draw's TEXT_JUSTIFY_CENTER anchor. Only shown when the user
    // has the setting on and the phone is actually connected.
    function drawBluetoothIcon(dc, x, y, debug) {
        if (!(isEnabled() || debug)) {
            return;
        }
        if (!System.getDeviceSettings().phoneConnected) {
            return;
        }

        var icon = IconTheme.getIcon(Rez.Drawables.bluetooth_dark, Rez.Drawables.bluetooth_light);
        dc.drawBitmap(x - (icon.getWidth() / 2), y - (icon.getHeight() / 2), icon);
    }
}
