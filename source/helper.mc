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
    var view;
	
	function initialize(viewReference){
		self.view = viewReference;
	}

	function fontHuge245(){
		return view.mFontHuge245;
	}

	function fontHuge45(){
		return view.mFontHuge45;
	}
	
	function fontMedium(){
		return view.mFontMedium;
	}
	
	function fontSmall(){
		return view.mFontSmall;
	}
	
	function fontIcons(){
		return view.mFontIcons;
	}
	function fontSmallIcons(){
		return view.mFontSmallIcons;
	}
	
	function getHours() {
		var hours = System.getClockTime().hour;
		if(!System.getDeviceSettings().is24Hour && hours > 12){
			hours = hours - 12;
		}
		return hours.format("%02d").toCharArray();
	}
	
	function useOldFont(){
		return view.mUseOldFont;
	}
	
	function showBottomLeft(){
		return view.mShowBottomLeft;
	}
	
	function whatToShowAtTop(){
		return view.mWhatToShowAtTop;
	}
	
	function whatToShowAtRight(){
		return view.mWhatToShowAtRight;
	}
	
	function whatToShowAtBottomLeft(){
		return view.mWhatToShowAtBottomLeft;
	}
	
	function whatToShowAtBottomLeft2(){
		return view.mWhatToShowAtBottomLeft2;
	}
	
	function whatToShowAtBottomLeft3(){
		return view.mWhatToShowAtBottomLeft3;
	}
	
	function bluetoothOption(){
		return view.mBTConnection;
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
		return getWeekdayName_(number, view.mFont);
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
        dc.setColor(Graphics.COLOR_TRANSPARENT, view.mBgColor);
    	dc.clear();
    	dc.setColor(view.mFgColor, Graphics.COLOR_TRANSPARENT);
	}
	
	function getSteps(){
        var steps = ActivityMonitor.getInfo().steps;
        if (steps == null) { steps = 0; }
		if(shortFormat){
			if(debug){ return "99999stps"; }
			return steps + "stps";
		}
	
		if(debug){ return "99999 steps"; }
		return steps + " steps";
	}
	function getCalories(){
        var calories = ActivityMonitor.getInfo().calories;
        if (calories == null) { calories = 0; }
		if(shortFormat){
			if(debug){ return "99999cal"; }
			return calories + "cal";
		}
		if(debug){ return "99999 calories"; }
		return calories + " calories";
	}
	
	function getMsgs(){
        var ntfCount = System.getDeviceSettings().notificationCount;
        if (ntfCount == null) { ntfCount = 0; }
		if(shortFormat){
			if(debug){ return "99msgs"; }
			return ntfCount + "msgs";
		}
		if(debug){ return "99 messages"; }
		return ntfCount + " messages";
	}
	
	function getBattery(){
        var batteryStats = System.getSystemStats().battery;
        var battery = 0;
        if (batteryStats != null) {
	        battery = batteryStats.format("%d");
        }

		if(shortFormat){
			if(debug){ return "100%"; }
			return battery + "%";
		}
		if(debug){ return "100% battery"; }
		return battery + "% battery";
	}
	
	function getHR(){
		var hr = Activity.getActivityInfo().currentHeartRate;
		if(hr == null){
            return shortFormat ? "--bpm" : "-- bpm";
        }
        return shortFormat ? hr + "bpm" : hr + " bpm";
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