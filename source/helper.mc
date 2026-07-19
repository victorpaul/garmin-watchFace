using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;
using Toybox.Application;

using Toybox.Time;
using Toybox.Time.Gregorian;

class helper {

	var debug, debugDate;
	var shortFormat=true;
	var weatherService;
	var batteryService;
	var stepsService;
	var floorsService;
	var messagesService;
	var hrService;
	var bluetoothService;
	var beepService;
	var useUaFont = false;

	function initialize(){
		weatherService = new weather();
		batteryService = new battery();
		stepsService = new steps();
		floorsService = new floors();
		messagesService = new messages();
		hrService = new hr();
		bluetoothService = new bluetooth();
		beepService = new beep();

		var deviceSettings = System.getDeviceSettings();
		var l = null;
		if (deviceSettings has :systemLanguage) {
			l = deviceSettings.systemLanguage;
		}
		useUaFont = l == System.LANGUAGE_UKR || l == System.LANGUAGE_POL || l == System.LANGUAGE_LIT;
	}

	function fontHuge245(){
		return WatchUi.loadResource(Rez.Fonts.fntHuge);
	}

	function fontHuge45(){
		return WatchUi.loadResource(Rez.Fonts.fntHuge45);
	}
	
	function fontMedium(){
		return fontMedium_(Application.getApp().getProperty("Font"));
	}

	function fontSmall(){
		return fontSmall_(Application.getApp().getProperty("Font"));
	}

	function fontMedium_(setting){
		if(useUaFont){
			return WatchUi.loadResource(Rez.Fonts.euaMedium);
		}
		switch(setting){
			case 2:
				return WatchUi.loadResource(Rez.Fonts.mediumJannScript);  // 36px
			case 3:
				return WatchUi.loadResource(Rez.Fonts.mediumStiffBrush); // 35px
			default:
				return WatchUi.loadResource(Rez.Fonts.fntMedium);
		}
	}

	function fontSmall_(setting){
		if(useUaFont){
			return WatchUi.loadResource(Rez.Fonts.euaSmall);
		}
		switch(setting){
			case 2:
				return WatchUi.loadResource(Rez.Fonts.smallJannScript);  // 26px
			case 3:
				return WatchUi.loadResource(Rez.Fonts.smallStiffBrush); // 26px
			default:
				return WatchUi.loadResource(Rez.Fonts.fntSmall);
		}
	}
	
	function getHours() {
		var hours = System.getClockTime().hour;
		var clockMode = System.getDeviceSettings().is24Hour;
		if(!clockMode && hours >12){
			hours = hours-12;
		}
		return hours.format("%02d").toCharArray();
	}
	
	
	function showBottomLeft(){
		return Application.getApp().getProperty("ShowBottomLeft");
	}
	
	function whatToShowAtTop(){
		return Application.getApp().getProperty("WhatToShowAtTop");
	}
	
	function whatToShowAtRight(){
		return Application.getApp().getProperty("WhatToShowAtRight");
	}
	
	function whatToShowAtBottomLeft(){
		return Application.getApp().getProperty("WhatToShowAtBottomLeft");
	}
	
	function whatToShowAtBottomLeft2(){
		return Application.getApp().getProperty("WhatToShowAtBottomLeft2");
	}
	
	function whatToShowAtBottomLeft3(){
		return Application.getApp().getProperty("WhatToShowAtBottomLeft3");
	}
	
	function getMonthName(number){
		// Debug: Print loaded string to verify language
		if(debug){
			System.println("MonthJan: " + WatchUi.loadResource(Rez.Strings.MonthJan));
		}
		switch(number){
			case 1: return WatchUi.loadResource(Rez.Strings.MonthJan);
			case 2: return WatchUi.loadResource(Rez.Strings.MonthFeb);
			case 3: return WatchUi.loadResource(Rez.Strings.MonthMar);
			case 4: return WatchUi.loadResource(Rez.Strings.MonthApr);
			case 5: return WatchUi.loadResource(Rez.Strings.MonthMay);
			case 6: return WatchUi.loadResource(Rez.Strings.MonthJun);
			case 7: return WatchUi.loadResource(Rez.Strings.MonthJul);
			case 8: return WatchUi.loadResource(Rez.Strings.MonthAug);
			case 9: return WatchUi.loadResource(Rez.Strings.MonthSep);
			case 10: return WatchUi.loadResource(Rez.Strings.MonthOct);
			case 11: return WatchUi.loadResource(Rez.Strings.MonthNov);
			case 12: return WatchUi.loadResource(Rez.Strings.MonthDec);
			default: return "-";		
		}
	}
	
	function getWeekdayName(number){
		return getWeekdayName_(number,Application.getApp().getProperty("Font"));
	}
	
	function getWeekdayName_(number,setting){
		if(setting == 1){
			switch(number){
				case 1: return WatchUi.loadResource(Rez.Strings.WeekdayShortSun);
				case 2: return WatchUi.loadResource(Rez.Strings.WeekdayShortMon);
				case 3: return WatchUi.loadResource(Rez.Strings.WeekdayShortTue);
				case 4: return WatchUi.loadResource(Rez.Strings.WeekdayShortWed);
				case 5: return WatchUi.loadResource(Rez.Strings.WeekdayShortThu);
				case 6: return WatchUi.loadResource(Rez.Strings.WeekdayShortFri);
				case 7: return WatchUi.loadResource(Rez.Strings.WeekdayShortSat);
				default: return "-";	
			}
		}
		
		switch(number){
			case 1: return WatchUi.loadResource(Rez.Strings.WeekdayLongSun);
			case 2: return WatchUi.loadResource(Rez.Strings.WeekdayLongMon);
			case 3: return WatchUi.loadResource(Rez.Strings.WeekdayLongTue);
			case 4: return WatchUi.loadResource(Rez.Strings.WeekdayLongWed);
			case 5: return WatchUi.loadResource(Rez.Strings.WeekdayLongThu);
			case 6: return WatchUi.loadResource(Rez.Strings.WeekdayLongFri);
			case 7: return WatchUi.loadResource(Rez.Strings.WeekdayLongSat);
			default: return "-";		
		}
	}
	
	function drawBluetoothConnectionSmall(dc,x,y){
		bluetoothService.drawBluetoothIcon(dc,x,y,debug);
	}

	function drawBluetoothConnection(dc,x,y){
		bluetoothService.drawBluetoothIcon(dc,x,y,debug);
	}

	function drawWeekDay2(dc,x,y,offset,font){
		var time = null;
		if(offset==0){
			time = Time.now();
		}else if (offset<0){
			time = Time.now().subtract(new Time.Duration(3600 *24 * (-offset)));
		}else if (offset>0){
			time = Time.now().add(new Time.Duration(3600 *24 * offset));
		}       	
    	var day = Gregorian.info(time, Time.FORMAT_SHORT);    	

    	dc.drawText(x,y, font, Lang.format(
	    	"$1$ $2$",
		    	[
			        getWeekdayName(day.day_of_week),
			        day.day.format("%02d")
			        
			    ]
			), Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	function setColors(dc){
		var bgColor = Application.getApp().getProperty("BackgroundColor");
        var fgColor = Application.getApp().getProperty("ForegroundColor");
        dc.setColor(Graphics.COLOR_TRANSPARENT, bgColor);
    	dc.clear();
    	dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
	}
	
	function getSteps(){
		return stepsService.getStepsNumber(debug);
	}

	function getFloors(){
		return floorsService.getFloorsNumber(debug);
	}
	function getCalories(){
		if(shortFormat){
			if(debug){
				return "99999cal";
			}
			return Lang.format("$1$$2$",[ActivityMonitor.getInfo().calories,WatchUi.loadResource(Rez.Strings.CaloriesShort)]);
		}
		if(debug){
			return "99999 calories";
		}
		return Lang.format("$1$ $2$",[ActivityMonitor.getInfo().calories,WatchUi.loadResource(Rez.Strings.CaloriesLong)]);
	}
	
	function getMsgs(){
		return messagesService.getMessagesNumber(debug);
	}
	
	function getBattery(){
		return batteryService.getBatteryText(shortFormat, debug);
	}
	
	function getHR(){
		return hrService.getHRNumber(debug);
	}
	
	function drawTop(dc,x,y){
		drawTopFA(whatToShowAtTop(),dc,x,y,fontSmall(),Graphics.TEXT_JUSTIFY_CENTER);
	}
	
	function drawTopLeft(dc,x,y){
		drawTopFA(whatToShowAtTop(),dc,x,y,fontSmall(),Graphics.TEXT_JUSTIFY_LEFT);
	}	        
	
	function drawTopFA(whatToSHow,dc,x,y,font,align){
		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		switch(whatToSHow){
			case 1:
	        	dc.drawText(x,y, font, Lang.format("$1$ $2$",[getMonthName(date.month),date.year]), align);
				break;
			case 2:
	        	dc.drawText(x,y, font, Lang.format("$1$ $2$",[getMonthName(date.month),date.day]), align);
				break;
			case 3:
	        	dc.drawText(x,y, font, Lang.format("$1$$2$,$3$",[getMonthName(date.month),date.day,date.year]), align);
				break;
			case 4:
	        	dc.drawText(x,y, font, Lang.format("$1$/$2$/$3$",[date.day,date.month,date.year]), align);
				break;
			case 5:
	        	dc.drawText(x,y, font, Lang.format("$1$/$2$/$3$",[date.month,date.day,date.year]), align);
				break;
			case 12:
	        	dc.drawText(x,y, font, Lang.format("$1$ $2$ $3$",[getMonthName(date.month),getWeekdayName(date.day_of_week),date.day]), align);
				break;
			case 6:
	    		stepsService.drawStepsIcon(dc, x, y, font, align, debug);
	    		break;
	    	case 7:
	    		dc.drawText(x,y, font,getCalories(),align);
	    		break;
			case 8:
	    		messagesService.drawMessagesIcon(dc, x, y, font, align, debug);
	    		break;
			case 9:
	    		dc.drawText(x,y, font,getBattery(),align);
	    		break;
    		case 10:
	    		hrService.drawHRIcon(dc, x, y, font, align, debug);
	    		break;
    		case 13:
	    		floorsService.drawFloorsIcon(dc, x, y, font, align, debug);
	    		break;
    		case 14:
	    		weatherService.drawWeather(dc, x, y, font, align);
	    		break;
			case 15:
				batteryService.drawBatteryIcon(dc, x, y, align);
				break;
			case 11:
				break;
		}

    	if(debugDate){
    		for(var t=1;t<=12;t++){dc.drawText(x,y,font, Lang.format("$1$ $2$",[getMonthName(t),date.year]), align);}
    	}	
        
	}

	function drawHeadString(whatToSHow){
		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		switch(whatToSHow){
			case 1:
	        	return Lang.format("$1$ $2$",[getMonthName(date.month),date.year]);
			case 2:
	        	return Lang.format("$1$ $2$",[getMonthName(date.month),date.day.format("%02d")]);
			case 3:
	        	return Lang.format("$1$ $2$,$3$",[getMonthName(date.month),date.day.format("%02d"),date.year]);
			case 4:
	        	return Lang.format("$1$/$2$/$3$",[date.day.format("%02d"),date.month.format("%02d"),date.year]);
			case 5:
	        	return Lang.format("$1$/$2$/$3$",[date.month.format("%02d"),date.day.format("%02d"),date.year]);
			case 12:
	        	return Lang.format("$1$ $2$ $3$",[getMonthName(date.month),getWeekdayName(date.day_of_week),date.day.format("%02d")]);
			case 6: 
	    		return getSteps();
	    	case 7: 
	    		return getCalories();
			case 8: 
	    		return getMsgs();
			case 9: 
	    		return getBattery();
    		case 10: 
	    		return getHR();
    		case 13: 
	    		return getFloors();
    		case 14:
	    		return weatherService.getTemperature();
			default:
				return "-";
		}
	}
	
	
	function drawHours(dc,hourX,hourY,adjX,adjY,hugefont){
		
		var hours = getHours();
        dc.drawText(hourX,hourY,hugefont,hours[0],Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+adjX,hourY+adjY,hugefont,hours[1],Graphics.TEXT_JUSTIFY_CENTER);
        if(debug){
	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	for(var t=0;t<=9;t++){dc.drawText(hourX+adjX,hourY+adjY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
		}
	}
	
	function drawMinutes(dc,minuteX,minuteY,adjX,adjY,hugefont){
		
    	var minutes = System.getClockTime().min.format("%02d").toCharArray();
    	dc.drawText(minuteX,minuteY,hugefont,minutes[0],Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(minuteX+adjX,minuteY+adjY,hugefont,minutes[1],Graphics.TEXT_JUSTIFY_CENTER);
    	if(debug){
	    	for(var t=0;t<=5;t++){dc.drawText(minuteX,minuteY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	for(var t=0;t<=9;t++){dc.drawText(minuteX+adjX,minuteY+adjY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
		}
	}
	
	function bonusDayInTop(top){
		if((top >=2 && top<=5) || top==12){
			return 1;
		}
		return 0;
	}
	
	function drawTopRight(whatToSHow,dc,x,y,stepY,startday,daysForward){
		drawTopRightFont(whatToSHow,dc,x,y,stepY,startday,daysForward,fontSmall());
	}
	function drawTopRightFont(whatToSHow,dc,x,y,stepY,startday,daysForward,font){
		var align = Graphics.TEXT_JUSTIFY_LEFT;
		switch(whatToSHow){
			case 1:
				var addDay = bonusDayInTop(whatToShowAtTop());
				for(var day=0;day<daysForward;day++){
		        	drawWeekDay2(dc,x,y+(stepY*day),startday+day+addDay,font);
		        }
				break;
			case 2:// deprecated, old shows connection to phone
			case 3:
				dc.drawText(x,y, font,getSteps(),align);
	    		dc.drawText(x,y+stepY, font, getFloors(),align);
	    		if(daysForward>=3){
					dc.drawText(x,y+stepY+stepY, font, getCalories(), align);
				}
				break;
			case 4:
			default:
				break;
		}
	}
	
	function drawBottomLineByOption(dc,x,y,option,font,align){
		if(align == null){
			align = Graphics.TEXT_JUSTIFY_RIGHT;
		}
		switch(option){
	    	case 1:
	    		stepsService.drawStepsIcon(dc, x, y, font, align, debug);
	    		break;
	    	case 2:
	    		dc.drawText(x,y, font,getCalories(),align);
	    		break;
			case 3:
	    		messagesService.drawMessagesIcon(dc, x, y, font, align, debug);
	    		break;
			case 4:
	    		dc.drawText(x,y, font,getBattery(),align);
	    		break;
    		case 5:
	    		hrService.drawHRIcon(dc, x, y, font, align, debug);
	    		break;
    		case 6:
	    		floorsService.drawFloorsIcon(dc, x, y, font, align, debug);
	    		break;
    		case 7:
	    		weatherService.drawWeather(dc, x, y, font, align);
	    		break;
    		case 9:
	    		batteryService.drawBatteryIcon(dc, x, y, align);
	    		break;
    		case 8:
    		default:
	    		break;
	    }
	}

	function drawBottomLeft(dc,x,y,stepY,font){
		if(showBottomLeft()){
	        drawBottomLineByOption(dc,x,y,whatToShowAtBottomLeft(),font,Graphics.TEXT_JUSTIFY_RIGHT);
	        drawBottomLineByOption(dc,x,y+stepY,whatToShowAtBottomLeft2(),font,Graphics.TEXT_JUSTIFY_RIGHT);
	        drawBottomLineByOption(dc,x,y+stepY+stepY,whatToShowAtBottomLeft3(),font,Graphics.TEXT_JUSTIFY_RIGHT);
        }
	}

	// Same as drawBottomLeft, but grows left-to-right (TEXT_JUSTIFY_LEFT)
	// instead of right-to-left - needed for narrow screens like
	// draw_148x205x3 where right-justified text can run off the left edge.
	function drawBottomLeftLeft(dc,x,y,stepY,font){
		if(showBottomLeft()){
	        drawBottomLineByOption(dc,x,y,whatToShowAtBottomLeft(),font,Graphics.TEXT_JUSTIFY_LEFT);
	        drawBottomLineByOption(dc,x,y+stepY,whatToShowAtBottomLeft2(),font,Graphics.TEXT_JUSTIFY_LEFT);
	        drawBottomLineByOption(dc,x,y+stepY+stepY,whatToShowAtBottomLeft3(),font,Graphics.TEXT_JUSTIFY_LEFT);
        }
	}

	// screenShape 1 = SCREEN_SHAPE_ROUND
	// screenShape 2 = SCREEN_SHAPE_SEMI_ROUND
	// screenShape 3 = SCREEN_SHAPE_RECTANGLE
	// screenShape 4 = SCREEN_SHAPE_SEMI_OCTAGON
	function ifScreen(screenWidth,screenHeight,screenShape){
		return 
			screenWidth == System.getDeviceSettings().screenWidth &&
			screenHeight == System.getDeviceSettings().screenHeight &&	
			screenShape == System.getDeviceSettings().screenShape;
	}
	
	function canBurn(){
		var sys = System.getDeviceSettings();
        if(sys has :requiresBurnInProtection) {
        	return sys.requiresBurnInProtection;        	
        }
        return false;
	}
	
	function setColorsOled(dc,inLowPower){
		if(inLowPower){
			dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
   			dc.clear();
   			dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
		}else{
			setColors(dc);
		}
	}
	
	function getAnalogClockPosition(step,value,radiusX,radiusY){
		var r = (360/step) * value;
		var radians=Math.toRadians(r);
		var x = Math.cos(radians)*radiusX;
		var y = Math.sin(radians)*radiusY;
		return [x,y];
	}

}
