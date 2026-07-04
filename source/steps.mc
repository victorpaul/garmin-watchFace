using Toybox.ActivityMonitor;

class steps {

    function initialize() {
    }

    function getStepsNumber(debug) {
        if (debug) {
            return "98765";
        }
        return ActivityMonitor.getInfo().steps.toString();
    }

    function drawStepsIcon(dc, x, y, font, align, debug) {
        IconTheme.drawIconWithText(dc, x, y, font, getStepsNumber(debug), align, Rez.Drawables.footprint_dark, Rez.Drawables.footprint_light);
    }
}
