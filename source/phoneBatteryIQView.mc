using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;

using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var prevWatchHash;

    function initialize() {
        WatchFace.initialize();
        System.println("initialize");
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        System.println("onLayout");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	prevWatchHash = "";
    	System.println("onShow");
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    System.println("onShow");
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	System.println("onExitSleep");
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	System.println("onEnterSleep");
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
			        day.day_of_week.substring(0,3).toLower().substring(0,2)
			    ]
			));	
	}

    // Update the view
    function onUpdate(dc) {
        var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d");
        var connected = System.getDeviceSettings().phoneConnected;
        var watchHash = minutes + "m" + connected + "p";
        if(!watchHash.equals(prevWatchHash)) {
        	prevWatchHash = watchHash+"";
        	
	        var stepsGoal = ActivityMonitor.getInfo().stepGoal;
	        var steps = ActivityMonitor.getInfo().steps;
	        var battery = System.getSystemStats().battery.format("%d")+"%";
	        var month = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM).month.toLower();
	        var hours = clockTime.hour.format("%02d");
	        
	        View.findDrawableById("topLabel").setText(connected?"BLE+":"BLE-");
	        View.findDrawableById("battery").setText(battery);
		    View.findDrawableById("steps").setText(Lang.format("$1$/$2$",[steps,stepsGoal]));
		    
	        View.findDrawableById("hours").setText(hours);
	        View.findDrawableById("minutes").setText(minutes);
		         
	        View.findDrawableById("month1").setText(month);
	        
	        drawWeekDay(0,-4);
	        drawWeekDay(1,-3);
	        drawWeekDay(2,-2);
	        drawWeekDay(3,-1);
	        drawWeekDay(4,0);
	        drawWeekDay(5,1l);
	        drawWeekDay(6,2);
	        drawWeekDay(7,3);
	        drawWeekDay(8,4);
	
	        // Call the parent onUpdate function to redraw the layout
	        View.onUpdate(dc);
        }
    }

}
