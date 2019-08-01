using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;

using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

	function drawWeekDay(position, offset){
		var time = null;
		if(offset==0){
			time = Time.now();
		}else if (offset<0){
			time = Time.now().subtract(new Time.Duration(3600 *24 * (-offset)));
		}else if (offset>0){
			time = Time.now().add(new Time.Duration(3600 *24 * offset));
		}       	
    	var day = Gregorian.info(time, Time.FORMAT_MEDIUM);
    	var weekDayView = View.findDrawableById("dayOfWeek" + position); 
    	weekDayView.setText(Lang.format(
	    	"$1$ $2$",
		    	[
			        day.day.format("%02d"),
			        day.day_of_week.substring(0,3).toLower()			        
			    ]
			));	
	}

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = System.getClockTime();

        View.findDrawableById("hours").setText(clockTime.hour.format("%02d"));
        View.findDrawableById("minutes").setText(clockTime.min.format("%02d"));

		var t = ActivityMonitor.getInfo();
        var stepsGoal = t.stepGoal;
        var steps = t.steps;
        
        View.findDrawableById("steps").setText(Lang.format("$1$\n$2$/$3$",["steps",steps,stepsGoal]));     
        View.findDrawableById("month1").setText(Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).month.toLower());
        
        drawWeekDay(1,-3);
        drawWeekDay(2,-2);
        drawWeekDay(3,-1);
        drawWeekDay(4,0);
        drawWeekDay(5,1l);
        drawWeekDay(6,2);
        drawWeekDay(7,3);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
