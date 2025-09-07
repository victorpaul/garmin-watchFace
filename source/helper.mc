using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.Activity;
using Toybox.Weather;

using Toybox.Time;
using Toybox.Time.Gregorian;

class helper {

	var debug, debugDate;
	var shortFormat=true;
	var useUaFont = false;
	
	function initialize(){
		var l = System.getDeviceSettings().systemLanguage;
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
	
	function fontIcons(){
		return WatchUi.loadResource(Rez.Fonts.icons);
	}
	function fontSmallIcons(){
		return WatchUi.loadResource(Rez.Fonts.smallicons);
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
	
	function bluetoothOption(){
		return Application.getApp().getProperty("BTCOnnection");
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
		drawBluetoothConnection_(dc,x,y,fontSmallIcons(),bluetoothOption());
	}
	
	function drawBluetoothConnection(dc,x,y){
		drawBluetoothConnection_(dc,x,y,fontIcons(),bluetoothOption());
	}
	
	function drawBluetoothConnection_(dc,x,y,font,setting){
		if(setting>0 || debug){
			if(System.getDeviceSettings().phoneConnected){
				var icon = "i";
				if(setting == 2){
					icon = "h";
				}
				if(setting == 3){
					icon = "g";
				}
				dc.drawText(x,y, fontIcons(), icon, Graphics.TEXT_JUSTIFY_CENTER);
			}
		}
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
		if(shortFormat){
			if(debug){
				return "99999stps";
			}
			return Lang.format("$1$$2$",[ActivityMonitor.getInfo().steps,WatchUi.loadResource(Rez.Strings.StepsShort)]);
		}
	
		if(debug){
			return "99999 steps";
		}
		return Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,WatchUi.loadResource(Rez.Strings.StepsLong)]);	
	}
	
	function getFloors(){
		if(shortFormat){
			if(debug){
				return "99flrs";
			}
			return Lang.format("$1$$2$",[ActivityMonitor.getInfo().floorsClimbed,WatchUi.loadResource(Rez.Strings.FloorsShort)]);
		}
	
		if(debug){
			return "99 floors";
		}
		return Lang.format("$1$ $2$",[ActivityMonitor.getInfo().floorsClimbed,WatchUi.loadResource(Rez.Strings.FloorsLong)]);	
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
		if(shortFormat){
			if(debug){
				return "99msgs";
			}
			var ntfCount = System.getDeviceSettings().notificationCount;	
			return Lang.format("$1$$2$",[ntfCount, WatchUi.loadResource(Rez.Strings.MessagesShort)]);
		}
		if(debug){
			return "99 messages";
		}
		var ntfCount = System.getDeviceSettings().notificationCount;	
		return Lang.format("$1$ $2$",[ntfCount, WatchUi.loadResource(Rez.Strings.MessagesLong)]);
	}
	
	function getBattery(){
		if(shortFormat){
			if(debug){	
				return "100%";
			}
			return Lang.format("$1$$2$",[System.getSystemStats().battery.format("%d")+"%", ""]);
		}
		if(debug){
			return "100% battery";
		}
		return Lang.format("$1$ $2$",[System.getSystemStats().battery.format("%d")+"%",WatchUi.loadResource(Rez.Strings.BatteryLong) ]);
	}
	
	function getHR(){
		var activityInfo = Activity.getActivityInfo();
		var hr = null;
		
		if (activityInfo != null) {
			hr = activityInfo.currentHeartRate;
		}
		
		if(shortFormat){
			if(hr != null && hr > 0){
				return Lang.format("$1$$2$",[hr, WatchUi.loadResource(Rez.Strings.BpmShort)]);
			}
			return WatchUi.loadResource(Rez.Strings.NoHeartRateShort);
		}
		
		if(hr != null && hr > 0){
			return Lang.format("$1$ $2$",[hr, WatchUi.loadResource(Rez.Strings.BpmLong)]);
		}
		return WatchUi.loadResource(Rez.Strings.NoHeartRateLong);
	}
	
	function drawTop(dc,x,y){
		drawTopFA(whatToShowAtTop(),dc,x,y,fontSmall(),Graphics.TEXT_JUSTIFY_CENTER);
	}
	
	function drawTopLeft(dc,x,y){
		drawTopFA(whatToShowAtTop(),dc,x,y,fontSmall(),Graphics.TEXT_JUSTIFY_LEFT);
	}	        
	
	function drawTopFA(whatToSHow,dc,x,y,font,align){
		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		dc.drawText(x,y, font, drawHeadString(whatToSHow), align);		
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
	    		return getWeather();
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
	
	function drawBottomLineByOption(dc,x,y,option,font){
		switch(option){
	    	case 1: 
	    		dc.drawText(x,y, font,getSteps(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
	    	case 2: 
	    		dc.drawText(x,y, font,getCalories(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
			case 3:
	    		dc.drawText(x,y, font,getMsgs(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
			case 4: 
	    		dc.drawText(x,y, font,getBattery(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
    		case 5: 
	    		dc.drawText(x,y, font,getHR(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
    		case 6: 
	    		dc.drawText(x,y, font,getFloors(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
    		case 7: 
	    		dc.drawText(x,y, font,getWeather(),Graphics.TEXT_JUSTIFY_RIGHT);
	    		break;
    		case 8:
    		default:
	    		break;
	    }
	}

	function getWeather(){
		if(debug){
			return "22°C ☀";
		}
		
		// Try to get weather data if available
		try {
			if (Weather has :getCurrentConditions) {
				var conditions = Weather.getCurrentConditions();
				if (conditions != null && conditions.temperature != null) {
					var temp = conditions.temperature.toNumber();
					var tempStr;
					
					if (System.getDeviceSettings().temperatureUnits == System.UNIT_METRIC) {
						tempStr = temp.format("%d") + "°C";
					} else {
						tempStr = temp.format("%d") + "°F";
					}
					
					//var icon = getWeatherIcon(conditions.condition);
					
					return tempStr;
				}
			}
		} catch(ex) {
			// Weather API not available or permission denied
		}
		
		return shortFormat ? "--°" : WatchUi.loadResource(Rez.Strings.NoWeatherShort);
	}
	
	function getWeatherIcon(condition) {
		if (condition == null) {
			return "?";
		}
		
		switch(condition) {
			case Weather.CONDITION_CLEAR:
				return "☀";
			case Weather.CONDITION_PARTLY_CLOUDY:
			case Weather.CONDITION_PARTLY_CLEAR:
				return "⛅";
			case Weather.CONDITION_CLOUDY:
			case Weather.CONDITION_MOSTLY_CLOUDY:
				return "☁";
			case Weather.CONDITION_RAIN:
			case Weather.CONDITION_LIGHT_RAIN:
			case Weather.CONDITION_HEAVY_RAIN:
			case Weather.CONDITION_SHOWERS:
				return "🌧";
			case Weather.CONDITION_SNOW:
			case Weather.CONDITION_LIGHT_SNOW:
			case Weather.CONDITION_HEAVY_SNOW:
			case Weather.CONDITION_CHANCE_OF_SNOW:
				return "❄";
			case Weather.CONDITION_THUNDERSTORMS:
			case Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
				return "⛈";
			case Weather.CONDITION_FOG:
			case Weather.CONDITION_HAZE:
			case Weather.CONDITION_MIST:
				return "🌫";
			case Weather.CONDITION_WINDY:
				return "💨";
			default:
				return "?";
		}
	}
	
	function drawBottomLeft(dc,x,y,stepY,font){
		if(showBottomLeft()){
	        drawBottomLineByOption(dc,x,y,whatToShowAtBottomLeft(),font);
	        drawBottomLineByOption(dc,x,y+stepY,whatToShowAtBottomLeft2(),font);
	        drawBottomLineByOption(dc,x,y+stepY+stepY,whatToShowAtBottomLeft3(),font);        	
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
