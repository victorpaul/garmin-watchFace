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

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = System.getClockTime();
        
        var timeString = Lang.format("$1$:$2$:$3$", [clockTime.hour, clockTime.min.format("%02d"),clockTime.sec]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);

		var t = ActivityMonitor.getInfo();
        var stepsGoal = t.stepGoal;
        var steps = t.steps;
        View.findDrawableById("steps").setText(Lang.format("$1$\n$2$/$3$",["steps",steps,stepsGoal]));
             
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT).day_of_week;	
        for(var weekDay=1; weekDay<=7; weekDay++){
        	var day = null;
        	var st = "";
        	if(weekDay<today){
        		var oneDay = new Time.Duration(3600 *24 * (today-weekDay));
        		var time = Time.now().subtract(oneDay);
        		day = Gregorian.info(time, Time.FORMAT_MEDIUM);
        		st="-";	
        	}
        	if(weekDay==today){
        		day = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        		st="*";	
        	}
        	if(weekDay>today){
        		var oneDay = new Time.Duration(3600 *24 * (weekDay-today));
        		var time = Time.now().add(oneDay);
        		day = Gregorian.info(time, Time.FORMAT_MEDIUM);
        		st="+";	
        	}
        	
			var dateString = Lang.format(
		    	"$1$ $2$ $3$ $4$ $5$",
		    	[
			        day.day_of_week.substring(0,3).toLower(),
			        day.day.format("%02d"),
			        day.month,
			        day.year,
			        st
			    ]
			);
        	View.findDrawableById("dayOfWeek" + weekDay).setText(dateString);
  		}

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
