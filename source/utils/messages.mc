using Toybox.System;

class messages {

    function initialize() {
    }

    function getMessagesNumber(debug) {
        if (debug) {
            return "99";
        }
        return System.getDeviceSettings().notificationCount.toString();
    }

    function drawMessagesIcon(dc, x, y, font, align, debug) {
        IconTheme.drawIconWithText(dc, x, y, font, getMessagesNumber(debug), align, Rez.Drawables.mail_dark, Rez.Drawables.mail_light);
    }
}
