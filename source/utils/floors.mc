using Toybox.ActivityMonitor;

class floors {

    var hasFloorsClimbed;

    function initialize() {
        hasFloorsClimbed = (ActivityMonitor.getInfo() has :floorsClimbed);
    }

    function getFloorsNumber(debug) {
        if (debug) {
            return "99";
        }
        if (!hasFloorsClimbed) {
            return "0";
        }
        var floorsClimbed = ActivityMonitor.getInfo().floorsClimbed;
        if (floorsClimbed == null) {
            return "0";
        }
        return floorsClimbed.toString();
    }

    function drawFloorsIcon(dc, x, y, font, align, debug) {
        IconTheme.drawIconWithText(dc, x, y, font, getFloorsNumber(debug), align, Rez.Drawables.floor_dark, Rez.Drawables.floor_light);
    }
}
