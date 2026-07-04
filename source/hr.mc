using Toybox.Activity;

class hr {

    function initialize() {
    }

    function getHRNumber(debug) {
        if (debug) {
            return "125";
        }

        var activityInfo = Activity.getActivityInfo();
        var currentHR = null;
        if (activityInfo != null) {
            currentHR = activityInfo.currentHeartRate;
        }

        if (currentHR != null && currentHR > 0) {
            return currentHR.toString();
        }
        return "--";
    }

    function drawHRIcon(dc, x, y, font, align, debug) {
        IconTheme.drawIconWithText(dc, x, y, font, getHRNumber(debug), align, Rez.Drawables.heart_dark, Rez.Drawables.heart_light);
    }
}
