using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;
using Toybox.Application;

using Toybox.Time;
using Toybox.Time.Gregorian;

class helper {

	var debug,debugDate;
	var shortFormat=true;
	
	function initialize(){
		
	}

	function fontHuge245(){
		return fontHuge245_(useOldFont());
	}
	function fontHuge245_(setting){
		if(setting){
			return WatchUi.loadResource(Rez.Fonts.fntHugeOld);	
		}
		return WatchUi.loadResource(Rez.Fonts.fntHuge);
	}

	function fontHuge45(){
		return fontHuge45_(useOldFont());
	}
	function fontHuge45_(setting){
		if(setting){
			return WatchUi.loadResource(Rez.Fonts.fntHugeOld);	
		}
		return WatchUi.loadResource(Rez.Fonts.fntHuge45);
	}
	
	function fontMedium(){
		return fontMedium_(Application.getApp().getProperty("Font"));
	}
	function fontMedium_(setting){
		switch(setting){
			case 2:
				return WatchUi.loadResource(Rez.Fonts.mediumJannScript);  // 36px
			case 3:
				return WatchUi.loadResource(Rez.Fonts.mediumStiffBrush); // 35px
			default:
				return WatchUi.loadResource(Rez.Fonts.fntMedium);
		}
	}
	
	function fontSmall(){
		return fontSmall_(Application.getApp().getProperty("Font"));
	}
	
	function fontIcons(){
		return WatchUi.loadResource(Rez.Fonts.icons);
	}
	function fontSmallIcons(){
		return WatchUi.loadResource(Rez.Fonts.smallicons);
	}
	
	function fontSmall_(setting){
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
	
	function useOldFont(){
		return Application.getApp().getProperty("UseOldFont");
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
		switch(number){
			case 1: return "Jan";
			case 2: return "Feb";
			case 3: return "Mar";
			case 4: return "Apr";
			case 5: return "May";
			case 6: return "Jun";
			case 7: return "Jul";
			case 8: return "Aug";
			case 9: return "Sep";
			case 10: return "Oct";
			case 11: return "Nov";
			case 12: return "Dec";
			default: return "-";		
		}
	}
	
	function getWeekdayName(number){
		return getWeekdayName_(number,Application.getApp().getProperty("Font"));
	}
	
	function getWeekdayName_(number,setting){
		if(setting == 1){
			switch(number){
				case 1: return "Sun";
				case 2: return "Mon";
				case 3: return "Tue";
				case 4: return "Wed";
				case 5: return "Thu";
				case 6: return "Fri";
				case 7: return "Sat";
				default: return "-";	
			}
		}
		
		switch(number){
			case 1: return "sun";
			case 2: return "mon";
			case 3: return "tue";
			case 4: return "wed";
			case 5: return "thu";
			case 6: return "fri";
			case 7: return "sat";
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
		if(setting>0){
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
			return Lang.format("$1$$2$",[ActivityMonitor.getInfo().steps,"stps"]);
		}
	
		if(debug){
			return "99999 steps";
		}
		return Lang.format("$1$ $2$",[ActivityMonitor.getInfo().steps,"steps"]);	
	}
	function getCalories(){
		if(shortFormat){
			if(debug){
				return "99999cal";
			}
			return Lang.format("$1$$2$",[ActivityMonitor.getInfo().calories,"cal"]);
		}
		if(debug){
			return "99999 calories";
		}
		return Lang.format("$1$ $2$",[ActivityMonitor.getInfo().calories,"calories"]);
	}
	
	function getMsgs(){
		if(shortFormat){
			if(debug){
				return "99msgs";
			}
			var ntfCount = System.getDeviceSettings().notificationCount;	
			return Lang.format("$1$$2$",[ntfCount, "msgs"]);
		}
		if(debug){
			return "99 messages";
		}
		var ntfCount = System.getDeviceSettings().notificationCount;	
		return Lang.format("$1$ $2$",[ntfCount, "messages"]);
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
		return Lang.format("$1$ $2$",[System.getSystemStats().battery.format("%d")+"%","battery" ]);
	}
	
	function getHR(){
		if(shortFormat){
			var hr = Activity.getActivityInfo().currentHeartRate;
			if(hr!=null){
				return Lang.format("$1$$2$",[hr, "bpm"]);
			}
			return "--bpm";
		}
		var hr = Activity.getActivityInfo().currentHeartRate;
			if(hr!=null){
				return Lang.format("$1$ $2$",[hr, "bpm"]);
			}
			return "-- bpm";
		
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
	    		dc.drawText(x,y, font,getSteps(),align);
	    		break;
	    	case 7: 
	    		dc.drawText(x,y, font,getCalories(),align);
	    		break;
			case 8: 
	    		dc.drawText(x,y, font,getMsgs(),align);
	    		break;
			case 9: 
	    		dc.drawText(x,y, font,getBattery(),align);
	    		break;
    		case 10: 
	    		dc.drawText(x,y, font,getHR(),align);
	    		break;
			case 11:
				break;
		}
			
    	if(debugDate){
    		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    		for(var t=1;t<=12;t++){dc.drawText(x,y,font, Lang.format("$1$ $2$",[getMonthName(t),date.year]), align);}
    	}
        
	}
	
	function getYfixForOldFont(){
		return getYfixForOldFont_(useOldFont());
	}
	
	function getYfixForOldFont_(setting){
		if(setting){
			switch(System.getDeviceSettings().screenHeight){
				case 205: return 35;
				case 148: return 35;
				case 180: return 20;
				case 208: return 35;
				case 218: return 25;
				case 240: return 65;
				case 260: return 65;
				case 280: return 65;
				case 390: return 65;
				default:return 0;
			}
		}
		return 0;
	}
	
	function drawHours(dc,hourX,hourY,adjX,adjY,hugefont){
		hourY+=getYfixForOldFont();	
		
		var hours = getHours();
        dc.drawText(hourX,hourY,hugefont,hours[0],Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(hourX+adjX,hourY+adjY,hugefont,hours[1],Graphics.TEXT_JUSTIFY_CENTER);
        if(debug){
	        for(var t=0;t<=2;t++){dc.drawText(hourX,hourY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
	    	for(var t=0;t<=9;t++){dc.drawText(hourX+adjX,hourY+adjY, hugefont, t, Graphics.TEXT_JUSTIFY_CENTER);}
		}
	}
	
	function drawMinutes(dc,minuteX,minuteY,adjX,adjY,hugefont){
		minuteY+=getYfixForOldFont();
		
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
		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
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
	    		dc.drawText(x,y+stepY, font,getCalories(),align);
	    		if(daysForward>=3){
					dc.drawText(x,y+stepY+stepY, font, Lang.format("$1$$2$,$3$",[getMonthName(date.month),date.day,date.year]), align);
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
    		default:
	    		break;
	    }
	}

	function getWeather(){
//		System.println("location");
//		System.println(Position.getInfo().position.lat);
//		System.println(Position.getInfo().position.lon);
//		
//		var key = "ff16abd420297723c28169e6eab2b41a";
//		var lat = 35;
//		var long = 139;
//		
//		Lang.format("$1$$2$$3$",["https://samples.openweathermap.org/data/2.5/weather?lat=",lat,"&lon=",long,"&appid=",key]);
		return "0"; 
	}
	
	function drawBottomLeft(dc,x,y,stepY,font){
		if(showBottomLeft()){
	        drawBottomLineByOption(dc,x,y,whatToShowAtBottomLeft(),font);
	        drawBottomLineByOption(dc,x,y+stepY,whatToShowAtBottomLeft2(),font);
	        drawBottomLineByOption(dc,x,y+stepY+stepY,whatToShowAtBottomLeft3(),font);        	
        }
	}
		
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
