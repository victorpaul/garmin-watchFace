using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;
using Toybox.Application;

using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var fontSmall,fontMedium,font;
	var selectedFont; 
	
    function initialize() {
        WatchFace.initialize();
        font = WatchUi.loadResource(Rez.Fonts.fntHuge);
		
		loadFont();
    }
	
	function loadFont(){
		if(selectedFont != Application.getApp().getProperty("Font")){
			selectedFont = Application.getApp().getProperty("Font");
			switch(selectedFont){
				case 1:
					fontMedium = WatchUi.loadResource(Rez.Fonts.fntMedium);
					fontSmall = WatchUi.loadResource(Rez.Fonts.fntSmall);
					break;
				case 2:
					fontMedium = WatchUi.loadResource(Rez.Fonts.mediumJannScript);  // 36px
        			fontSmall = WatchUi.loadResource(Rez.Fonts.smallJannScript);  // 26px
					break;
				case 3:
					fontMedium = WatchUi.loadResource(Rez.Fonts.mediumStiffBrush); // 35px
        			fontSmall = WatchUi.loadResource(Rez.Fonts.smallStiffBrush); // 26px
					break;
				case 4:
					fontMedium = WatchUi.loadResource(Rez.Fonts.mediumKeyVirtue); // 35px
        			fontSmall = WatchUi.loadResource(Rez.Fonts.smallKeyVirtue); // 26px
        			break;
			}
    	}
	}
	
    function getSmallFont(){
    	loadFont();
    	return fontSmall;
	}

    // Load your resources here
    function onLayout(dc) {
//        setLayout(Rez.Layouts.WatchFace(dc));
        //prevWatchHash = "";
        //System.println("onLayout");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	//prevWatchHash = "";
    	//System.println("onShow");
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    //	prevWatchHash = "";
    	//System.println("onShow");
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
  //  prevWatchHash = "";
    	//System.println("onExitSleep");
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
//    	prevWatchHash = "";
    	//System.println("onEnterSleep");
    }
	
	function getHours() {
		var hours = System.getClockTime().hour;
		if(Application.getApp().getProperty("Use12Hours") && hours >12){
			hours = hours-12;
		}
		return hours.format("%02d").toCharArray();
	}
	
	function showDays(){
		return Application.getApp().getProperty("ShowDays");
	}
	
	function showMonthYear(){
		return Application.getApp().getProperty("ShowMonthYear");
	}
	
	function showBottomLeft(){
		return Application.getApp().getProperty("ShowBottomLeft");
	}	
	
	function getMonthName(number){
		
		switch(number){
			case 8: return "Aug";
			case 9: return "Sep";
			case 10: return "Oct";
			case 11: return "Nov";
			case 12: return "Dec";
			case 1: return "Jan";
			case 2: return "Feb";
			case 3: return "Mar";
			case 4: return "Apr";
			case 5: return "May";
			case 6: return "Jun";
			case 7: return "Jul";			
		}
	}
	
	function getWeekdayName(number){
		
		switch(number){
			case 1: return "Sun";
			case 2: return "Mon";
			case 3: return "Tue";
			case 4: return "Wed";
			case 5: return "Thu";
			case 6: return "Fri";
			case 7: return "Sat";			
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
    	var day = Gregorian.info(time, Time.FORMAT_SHORT);    	

    	dc.drawText(x,y, getSmallFont(), Lang.format(
	    	"$1$ $2$",
		    	[
			        getWeekdayName(day.day_of_week),
			        day.day.format("%02d")
			        
			    ]
			), Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	function drawHugeWatches(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
//        var connected = System.getDeviceSettings().phoneConnected;
        var notifications = System.getDeviceSettings().notificationCount;
        //var alarms = System.getDeviceSettings().alarmCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
//        var watchHash = minutes + "m" + "p" + bgColor + fgColor + notifications + useBrushFont() + showBottomLeft() + showDays();
//    
//    	if(!watchHash.equals(prevWatchHash)) {
//        	prevWatchHash = watchHash+"";
        	
        	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", "battr"]);
	        var steps = Lang.format("$1$/$2$",[ActivityMonitor.getInfo().steps,ActivityMonitor.getInfo().stepGoal]);
	        var topLabel = Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);	        
	        var hours = getHours();
        	
        	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
	    	dc.clear();
	    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
	        
	        var topX = 115;
	        var topY = 5;
			
			var rightTopX = 135;
	      	var rightTopY = 40;
	      	
			var hourX = 45;
			var hourY = 11;
			var minuteX = 150;
			var minuteY = 80;

	      	var leftBottomX = 110;
	      	var leftBottomY = 155;
	        
//	        if(connected){
//    			dc.drawText(115,135, fontSmall, "B", Graphics.TEXT_JUSTIFY_RIGHT);
//	        }
	        
	        if(showMonthYear()){
	        	dc.drawText(topX,topY, fontMedium, topLabel, Graphics.TEXT_JUSTIFY_CENTER);
	        	//for(var t=1;t<=12;t++){dc.drawText(topX,topY, fontMedium, Lang.format("$1$ $2$",[getMonthName(t),date.year]), Graphics.TEXT_JUSTIFY_CENTER);}
	        }
	        
	        if(showDays()){
		        drawWeekDay2(dc,rightTopX,rightTopY,0);
		        drawWeekDay2(dc,rightTopX,rightTopY+20,1);
		        drawWeekDay2(dc,rightTopX,rightTopY+40,2);
	//	        drawWeekDay2(dc,rightTopX,rightTopY+60,3);
			}
	      	
	        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
	        dc.drawText(hourX+45,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
	        
//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+45,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	
	    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(minuteX+45,minuteY-20, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
	    	
//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+45,minuteY-20, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

			if(showBottomLeft()){
		        dc.drawText(leftBottomX+2,leftBottomY, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
		        dc.drawText(leftBottomX,leftBottomY+20, getSmallFont(),battery, Graphics.TEXT_JUSTIFY_RIGHT);
		        if(notifications>0){
		        	dc.drawText(leftBottomX+1,leftBottomY+40, getSmallFont(), notifications + " msgs", Graphics.TEXT_JUSTIFY_RIGHT);
		        }
	        }
	        	
//    	}
	}
	
	function draw_fenix6(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        var notifications = System.getDeviceSettings().notificationCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
  	
    	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", "battery"]);
        var steps = Lang.format("$1$/$2$",[ActivityMonitor.getInfo().steps,ActivityMonitor.getInfo().stepGoal]);
        var topLabel = Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);	        
        var hours = getHours();
    	
    	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
    	dc.clear();
    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        
        var topX = 115;
        var topY = 5;
		
		var rightTopX = 130;
      	var rightTopY = 40;
      	
		var hourX = 45;
		var hourY = 15;
		var minuteX = 170;
		var minuteY = 100;

      	var leftBottomX = 135;
      	var leftBottomY = 165;
        
        if(showMonthYear()){
        	dc.drawText(topX,topY, fontMedium, topLabel, Graphics.TEXT_JUSTIFY_CENTER);
        	//for(var t=1;t<=12;t++){dc.drawText(topX,topY, fontMedium, Lang.format("$1$ $2$",[getMonthName(t),date.year]), Graphics.TEXT_JUSTIFY_CENTER);}
        }
               
        if(showDays()){
	        drawWeekDay2(dc,rightTopX,rightTopY,0);
	        drawWeekDay2(dc,rightTopX,rightTopY+20,1);
	        drawWeekDay2(dc,rightTopX,rightTopY+40,2);
	        drawWeekDay2(dc,rightTopX,rightTopY+60,3);
		}
      	
        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+45,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
        
//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+45,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
    	
    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(minuteX+45,minuteY-20, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
    	
//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+45,minuteY-20, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

		if(showBottomLeft()){
	        dc.drawText(leftBottomX,leftBottomY, getSmallFont(),battery, Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        dc.drawText(leftBottomX+1,leftBottomY+20, getSmallFont(), notifications + " messages", Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX+2,leftBottomY+40, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
        }
	}
	
	function draw_fenix6xpro(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        var notifications = System.getDeviceSettings().notificationCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
  	
    	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", "battery"]);
        var steps = Lang.format("$1$/$2$",[ActivityMonitor.getInfo().steps,ActivityMonitor.getInfo().stepGoal]);
        var topLabel = Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);	        
        var hours = getHours();
    	
    	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
    	dc.clear();
    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        
        var topX = 125;
        var topY = 10;
		
		var rightTopX = 140;
      	var rightTopY = 40;
      	
		var hourX = 45;
		var hourY = 15;
		var minuteX = 185;
		var minuteY = 120;

      	var leftBottomX = 145;
      	var leftBottomY = 170;
        
       
        if(showMonthYear()){
        	dc.drawText(topX,topY, fontMedium, topLabel, Graphics.TEXT_JUSTIFY_CENTER);
        	//for(var t=1;t<=12;t++){dc.drawText(topX,topY, fontMedium, Lang.format("$1$ $2$",[getMonthName(t),date.year]), Graphics.TEXT_JUSTIFY_CENTER);}
        }
        
        if(showDays()){
	        drawWeekDay2(dc,rightTopX,rightTopY,0);
	        drawWeekDay2(dc,rightTopX,rightTopY+20,1);
	        drawWeekDay2(dc,rightTopX,rightTopY+40,2);
	        drawWeekDay2(dc,rightTopX,rightTopY+60,3);
	        drawWeekDay2(dc,rightTopX,rightTopY+80,4);
		}
      	
        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+45,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
        
//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+45,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
    	
    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(minuteX+45,minuteY-20, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
    	
//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+45,minuteY-20, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

		if(showBottomLeft()){
	        dc.drawText(leftBottomX,leftBottomY, getSmallFont(),battery, Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        dc.drawText(leftBottomX+1,leftBottomY+20, getSmallFont(), notifications + " messages", Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX+2,leftBottomY+40, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
        }
	}
	
	function draw_fr45(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        //var connected = System.getDeviceSettings().phoneConnected;
        var notifications = System.getDeviceSettings().notificationCount;
        //var alarms = System.getDeviceSettings().alarmCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
        	
    	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", ""]);
        var steps = Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,"steps"]);
        var topLabel = Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);	        
        var hours = getHours();
    	
    	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
    	dc.clear();
    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        
        var topX = 110;
        var topY = 5;
		
		var rightTopX = 118;
      	var rightTopY = 28;
      	
		var hourX = 35;
		var hourY = -2;
		var minuteX = 120;
		var minuteY = 70;

      	var leftBottomX = 95;
      	var leftBottomY = 135;
        
        if(showMonthYear()){
        	dc.drawText(topX,topY, getSmallFont(), topLabel, Graphics.TEXT_JUSTIFY_CENTER);
        	//for(var t=1;t<=12;t++){dc.drawText(topX,topY, fontMedium, Lang.format("$1$ $2$",[getMonthName(t),date.year]), Graphics.TEXT_JUSTIFY_CENTER);}
        }
        
        if(showDays()){
	        drawWeekDay2(dc,rightTopX,rightTopY,0);
	        drawWeekDay2(dc,rightTopX,rightTopY+20,1);
	        drawWeekDay2(dc,rightTopX,rightTopY+40,2);
        }
//	        drawWeekDay2(dc,rightTopX,rightTopY+60,3);
      	
        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+45,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
        
//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+45,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
    	
    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(minuteX+45,minuteY-20, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
    	
//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+45,minuteY-20, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

		if(showBottomLeft()){
	        dc.drawText(leftBottomX+2,leftBottomY, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX+1,leftBottomY+18, getSmallFont(), notifications + " msgs", Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX,leftBottomY+36, getSmallFont(),battery, Graphics.TEXT_JUSTIFY_RIGHT);
//	        if(notifications>0){
//	        	
//	        }
        }
	
	}
	
	function draw_fenix3(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        //var connected = System.getDeviceSettings().phoneConnected;
        var notifications = System.getDeviceSettings().notificationCount;
        //var alarms = System.getDeviceSettings().alarmCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
        	
    	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", ""]);
        var steps = Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,"steps"]);
        var topLabel = Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);	        
        var hours = getHours();
    	
    	
    	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
    	dc.clear();
    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        
        var topX = 110;
        var topY = 5;
		
		var rightTopX = 118;
      	var rightTopY = 28;
      	
		var hourX = 35;
		var hourY = -2;
		var minuteX = 130;
		var minuteY = 75;

      	var leftBottomX = 103;
      	var leftBottomY = 135;
        
        if(showMonthYear()){
        	dc.drawText(topX,topY, getSmallFont(), topLabel, Graphics.TEXT_JUSTIFY_CENTER);
        	//for(var t=1;t<=12;t++){dc.drawText(topX,topY, fontMedium, Lang.format("$1$ $2$",[getMonthName(t),date.year]), Graphics.TEXT_JUSTIFY_CENTER);}
        }
        
        if(showDays()){
	        drawWeekDay2(dc,rightTopX,rightTopY,0);
	        drawWeekDay2(dc,rightTopX,rightTopY+20,1);
	        drawWeekDay2(dc,rightTopX,rightTopY+40,2);
        }

        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+45,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);
        
//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+45,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
    	
    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(minuteX+45,minuteY-20, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);
    	
//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+45,minuteY-20, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

		if(showBottomLeft()){
	        dc.drawText(leftBottomX+2,leftBottomY, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX+1,leftBottomY+18, getSmallFont(), notifications + " msgs", Graphics.TEXT_JUSTIFY_RIGHT);
	        dc.drawText(leftBottomX,leftBottomY+36, getSmallFont(),battery, Graphics.TEXT_JUSTIFY_RIGHT);
//	        if(notifications>0){
//	        	
//	        }
        }
	
	}
	
	function draw_fr230_fr235(dc){
		var clockTime = System.getClockTime();
        var minutes = clockTime.min.format("%02d").toCharArray();
        //var connected = System.getDeviceSettings().phoneConnected;
        var notifications = System.getDeviceSettings().notificationCount;
        //var alarms = System.getDeviceSettings().alarmCount;
        var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
//        var watchHash = minutes + "m" + "p" + bgColor + fgColor + notifications + useBrushFont() + showBottomLeft() + showDays();
//    
//    	if(!watchHash.equals(prevWatchHash)) {
//        	prevWatchHash = watchHash+"";
        	
        	var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        var topLabel = Lang.format("$1$$2$",[getMonthName(date.month),date.year]);	        
	        var hours = getHours();

			var battery = Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", "battr"]);
	        var steps = Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,"steps"]);
	        
        	dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
	    	dc.clear();
	    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
	        
	        var topX = 110;
	        var topY = 3;
			
			var rightTopX = 135;
	      	var rightTopY = 40;
	      	
			var hourX = 35;
			var hourY = -20;
			var minuteX = 130;
			var minuteY = 25;

	      	var leftBottomX = 90;
	      	var leftBottomY = 120;
	       
	        if(showMonthYear()){
	       		dc.drawText(topX,topY, getSmallFont(), topLabel, Graphics.TEXT_JUSTIFY_LEFT);
	        }
	        
	        if(showDays()){
	        	drawWeekDay2(dc,topX,topY+16,0);
	        	drawWeekDay2(dc,topX,topY+31,1);
	        }

	        dc.drawText(hourX,hourY, font, hours[0], Graphics.TEXT_JUSTIFY_CENTER);
	        dc.drawText(hourX+40,hourY, font, hours[1], Graphics.TEXT_JUSTIFY_CENTER);

//	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(hourX+50,hourY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

	    	dc.drawText(minuteX,minuteY, font, minutes[0], Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(minuteX+50,minuteY, font, minutes[1], Graphics.TEXT_JUSTIFY_CENTER);

//	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}
//	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+50,minuteY, font, t, Graphics.TEXT_JUSTIFY_CENTER);}

			if(showBottomLeft()){
		        dc.drawText(leftBottomX,leftBottomY, getSmallFont(),battery,Graphics.TEXT_JUSTIFY_RIGHT);
		        dc.drawText(leftBottomX,leftBottomY+16, getSmallFont(),steps,Graphics.TEXT_JUSTIFY_RIGHT);
		        if(notifications>0){
		        	dc.drawText(leftBottomX+10,leftBottomY+32, getSmallFont(), notifications + " msgs", Graphics.TEXT_JUSTIFY_RIGHT);
		        }
	        }

//    	}
	}
	
	function ifScreen(screenWidth,screenHeight,screenShape){
		return 
			screenWidth == System.getDeviceSettings().screenWidth &&
			screenHeight == System.getDeviceSettings().screenHeight &&	
			screenShape == System.getDeviceSettings().screenShape;
	}
	
    // Update the view
    function onUpdate(dc) {
        //drawWatch(dc);

		System.println(System.getDeviceSettings().screenWidth);
		System.println(System.getDeviceSettings().screenHeight);
		System.println(System.getDeviceSettings().screenShape);
		
		// var hrIterator = ActivityMonitor.getHeartRateHistory(null,true);
		// System.println(hrIterator.next().heartRate);
		
		
		if(ifScreen(215,180,2)){
			draw_fr230_fr235(dc);	
			return;
		}
		if(ifScreen(208,208,1)){
			draw_fr45(dc);	
			return;
		}
		if(ifScreen(218,218,1)){
			draw_fenix3(dc);	
			return;
		}
		if(ifScreen(260,260,1)){
			draw_fenix6(dc);	
			return;
		}
		if(ifScreen(280,280,1)){
			draw_fenix6xpro(dc);	
			return;
		}

		drawHugeWatches(dc);
		
    }

}
