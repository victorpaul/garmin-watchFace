using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;

using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var prevWatchHash;
	var font,fontSmall;
	
    function initialize() {
        WatchFace.initialize();
        font = WatchUi.loadResource(Rez.Fonts.fnt1);
        fontSmall = WatchUi.loadResource(Rez.Fonts.fnt3);
        prevWatchHash = "";
        System.println("initialize");			
    }

    // Load your resources here
    function onLayout(dc) {
//        setLayout(Rez.Layouts.WatchFace(dc));
        prevWatchHash = "";
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
    	prevWatchHash = "";
    	System.println("onShow");
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    prevWatchHash = "";
    	System.println("onExitSleep");
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	prevWatchHash = "";
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
	
	function drawWatch(dc) {
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d");
        var connected = System.getDeviceSettings().phoneConnected;
        var watchHash = minutes + "m" + connected + "p";

        if(!watchHash.equals(prevWatchHash)) {
        	prevWatchHash = watchHash+"";
        	
        	var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
	        var stepsGoal = ActivityMonitor.getInfo().stepGoal;
	        var steps = ActivityMonitor.getInfo().steps;
	        var battery = Lang.format("$1$ $2$",["battery",System.getSystemStats().battery.format("%d")+"%"]);
	        var topLabel = Lang.format("$1$ $2$",[date.month,date.year]);	        
	        var hours = clockTime.hour.format("%02d");
	
			View.findDrawableById("toplabel").setText(topLabel);
	
			//View.findDrawableById("bluetooth").setBitmap(connected?Rez.Drawables.BluetoothOn:Rez.Drawables.BluetoothOff);
	        View.findDrawableById("battery").setText(battery);
		    
	        //View.findDrawableById("hours").setText(hours);
	        //View.findDrawableById("minutes").setText(minutes);
		         
	        View.findDrawableById("steps").setText(Lang.format("$1$ $2$",["steps",steps]));
	        
//	        drawWeekDay(0,-4);
	        drawWeekDay(1,-3);
	        drawWeekDay(2,-2);
	        drawWeekDay(3,-1);
	        drawWeekDay(4,0);
	        drawWeekDay(5,1l);
	        drawWeekDay(6,2);
	        drawWeekDay(7,3);
//	        drawWeekDay(8,4);
	    	
	    	View.onUpdate(dc);
	    	
        }

	}
	
	function drawWeekDay2(dc,x,y,offset){
		var time = null;
		if(offset==0){
			time = Time.now();
		}else if (offset<0){
			time = Time.now().subtract(new Time.Duration(3600 *24 * (-offset)));
		}else if (offset>0){
			time = Time.now().add(new Time.Duration(3600 *24 * offset));
		}       	
    	var day = Gregorian.info(time, Time.FORMAT_LONG);    	
    	
    	dc.drawText(x,y, fontSmall, Lang.format(
	    	"$1$ $2$ ",
		    	[
			        day.day_of_week,
			        day.day.format("%02d")
			        
			    ]
			), Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	function drawHugeWatches(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        var connected = System.getDeviceSettings().phoneConnected;
        var watchHash = minutes + "m" + connected + "p";
    
    	if(!watchHash.equals(prevWatchHash)) {
        	prevWatchHash = watchHash+"";
        	
        	var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
	        var stepsGoal = ActivityMonitor.getInfo().stepGoal;
	        var steps = Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,"steps"]);
	        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", "battery"]);
	        var topLabel = Lang.format("$1$ $2$",[date.month,date.year]);	        
	        var hours = clockTime.hour.format("%02d").toCharArray();
        	
        	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
	    	dc.clear();
	    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	        
	        dc.drawText(110,10, fontSmall, topLabel, Graphics.TEXT_JUSTIFY_CENTER);
	        
	        //dc.drawText(135,50, fontSmall, steps, Graphics.TEXT_JUSTIFY_LEFT);
	        //dc.drawText(135,80, fontSmall, battery, Graphics.TEXT_JUSTIFY_LEFT);
	        drawWeekDay2(dc,140,30,0);
	        drawWeekDay2(dc,140,50,1);
	        drawWeekDay2(dc,140,70,2);
	        drawWeekDay2(dc,140,90,3);
	      
	        dc.drawText(50,-30, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
	        dc.drawText(105,-30, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
	        
//	        for(var t=0;t<=5;t++){dc.drawText(50,-30, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(105,-30, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	
	    	dc.drawText(130,50, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(190,40, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
	    	
//	    	for(var t=0;t<=5;t++){dc.drawText(130,50, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(190,40, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	
	        dc.drawText(103,140, fontSmall, battery, Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(103,160, fontSmall, steps, Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(100,185, fontSmall, "B", Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        if(!connected){
	        	dc.drawText(95,180, fontSmall, "X", Graphics.TEXT_JUSTIFY_RIGHT);	
	        }
	        //dc.drawBitmap(85, 185, connected?Rez.Drawables.BluetoothOn:Rez.Drawables.BluetoothOff)	        
	    	
	//    	for(var t=0;t<=23;t++){
	    		//dc.drawText(130,-20, font, hours, Graphics.TEXT_JUSTIFY_CENTER);	
	//    		dc.drawText(75,-30, font, t.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER);
	//    	}
	    	//dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
	//    	for(var t=0;t<=59;t++){
				//dc.drawText(175,30, font, minutes, Graphics.TEXT_JUSTIFY_CENTER);
	//			dc.drawText(150,40, font, t.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER);
	//		}	
    	}
	}
	
    // Update the view
    function onUpdate(dc) {
        //drawWatch(dc);
        drawHugeWatches(dc);
    }

}
