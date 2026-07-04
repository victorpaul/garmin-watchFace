using Toybox.ActivityMonitor;

class floors {

    function initialize() {
    }

    function getFloorsNumber(debug) {
        if (debug) {
            return "99";
        }
        return ActivityMonitor.getInfo().floorsClimbed.toString();
    }

    function drawFloorsIcon(dc, x, y, font, align, debug) {
        IconTheme.drawIconWithText(dc, x, y, font, getFloorsNumber(debug), align, Rez.Drawables.floor_dark, Rez.Drawables.floor_light);
    }
}
