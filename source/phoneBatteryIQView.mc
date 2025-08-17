using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Attention;
using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	var inLowPower=false;
	var lastPhoneConnectionState = null;
	var deviceType = null;
	var isOledDisplay = false;
	var fontsMode = false;
	
    function initialize() {
        WatchFace.initialize();
        
        uiH = new helper();
        uiH.debug = false;
		uiH.debugDate = false;
		
		initializeDevice();
    }
    
    function initializeDevice() {
        var deviceInfo = DeviceService.getDeviceInfo(uiH.debug);
        deviceType = deviceInfo[:deviceType];
        isOledDisplay = deviceInfo[:isOled];
    }
    
    function onExitSleep() {
        inLowPower=false;
    	WatchUi.requestUpdate(); 
    }

    function onEnterSleep() {
    	inLowPower=true;
    	WatchUi.requestUpdate(); 
    }
    
    function checkPhoneConnectionAndBeep() {
        var beepEnabled = Application.Properties.getValue("BeepOnPhoneDisconnect");
        if (beepEnabled == null) {
            beepEnabled = false;
        }
        
        if (beepEnabled) {
            var currentConnectionState = System.getDeviceSettings().phoneConnected;
            
            if (lastPhoneConnectionState == true && currentConnectionState == false) {
                if (Attention has :ToneProfile) {
                    var toneProfile = [
                        new Attention.ToneProfile(2500, 200),
                        new Attention.ToneProfile(0, 100),
                        new Attention.ToneProfile(2500, 200)
                    ];
                    Attention.playTone({:toneProfile=>toneProfile});
                }
                if (Attention has :VibeProfile && Attention has :vibrate) {
                    var vibeData = [
                        new Attention.VibeProfile(50, 200),
                        new Attention.VibeProfile(0, 100),
                        new Attention.VibeProfile(50, 200)
                    ];
                    Attention.vibrate(vibeData);
                }
            }
            
            lastPhoneConnectionState = currentConnectionState;
        }
    }
	
	function draw_vivoactiveHR(dc){
    	var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,88,-5,14,0,6);
  		uiH.drawHours(dc,25,-62,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,70,30,50,0,uiH.fontHuge45());
		
		dc.drawText(2,130, uiH.fontSmall(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(2,150, uiH.fontSmall(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		
		uiH.drawBluetoothConnectionSmall(dc,12,178);
	}

	function draw_176x176x4(dc) {
		var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,116,11,14,0,2);
  		uiH.drawHours(dc,30,-65,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,95,10,50,0,uiH.fontHuge45());
		
		
		dc.drawText(10,95, uiH.fontSmall(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(10,115, uiH.fontSmall(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,50,137);
	}

	function draw_163x156x4(dc) {
		var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,109,4,14,0,2);
  		uiH.drawHours(dc,25,-69,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,80,-5,50,0,uiH.fontHuge45());
		
		
		dc.drawText(5,80, uiH.fontSmall(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(5,100, uiH.fontSmall(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,40,120);
	}

	
	function draw_166x166x4(dc) {
		var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,112,4,14,0,2);
  		uiH.drawHours(dc,25,-65,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,87,-5,50,0,uiH.fontHuge45());
		
		
		dc.drawText(5,95, uiH.fontSmall(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(5,115, uiH.fontSmall(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,40,135);
	}
	
	function draw_fr920xt(dc){
		var topRight=uiH.whatToShowAtRight();
		
		uiH.drawTopLeft(dc,107,-5);
    	uiH.drawTopRight(topRight,dc,107,13,15,0,1);
  		uiH.drawHours(dc,28,-60,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,125,-30,50,0,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,85,100,14,uiH.fontSmall());
	}
	
	function draw_fr230_fr235(dc){
		var topRight=uiH.whatToShowAtRight();
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,110,19,15,0,3);
  		uiH.drawHours(dc,35,-35,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,125,3,50,0,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,92,120,18,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,135,152);
	}

	function draw_venusq(dc){
		var topRight=uiH.whatToShowAtRight();
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,110,19,15,0,3);
  		uiH.drawHours(dc,35,-35,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,150,3,50,0,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,92,120,18,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,135,152);
	}
	
	function draw_fenix3(dc){
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(topRight,dc,118,28,20,0,3);
      	uiH.drawHours(dc,35,-15,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,130,35,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,98,140,19,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,210,110);
	}
	
	function draw_fr45(dc){
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,8);
        uiH.drawTopRight(topRight,dc,115,25,17,0,3);
      	uiH.drawHours(dc,35,-20,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,121,30,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,93,136,17,uiH.fontSmall());
		
		uiH.drawBluetoothConnectionSmall(dc,199,108);
	}
	
	function draw_fr245_fenix5x(dc) {
		var topCenter=uiH.whatToShowAtTop();
		var topRight=uiH.whatToShowAtRight();

        uiH.drawTopFA(topCenter,dc,120,5,uiH.fontSmall(),Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,125,25,20,0,3);
      	uiH.drawHours(dc,40,-40,45,-20,uiH.fontHuge245());
    	uiH.drawMinutes(dc,145,20,45,-20,uiH.fontHuge245());
		uiH.drawBottomLeft(dc,108,152,20,uiH.fontSmall());
		
		uiH.drawBluetoothConnection(dc,135,84);
	}
		
	function draw_fenix6(dc){
		var topCenter=uiH.whatToShowAtTop();
		var topRight=uiH.whatToShowAtRight();
	
        uiH.drawTopFA(topCenter,dc,130,5,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,115,32,19,0,4);
        if(topRight==1){
        	uiH.drawTopRight(topRight,dc,180,50,19,4,3);
        }
        
      	uiH.drawHours(dc,35,-20,45,-20,uiH.fontHuge245());
    	uiH.drawMinutes(dc,160,37, 45,-20,uiH.fontHuge245());
		uiH.drawBottomLeft(dc,125,165,19,uiH.fontSmall());
		
		uiH.drawBluetoothConnection(dc,120,225);
	}
	
	function draw_fenix6xpro(dc){
		var topCenter=uiH.whatToShowAtTop();
		var topRight=uiH.whatToShowAtRight();
        uiH.drawTopFA(topCenter,dc,133,10,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,127,40,20,0,4);
        if(topRight==1){
        	uiH.drawTopRight(topRight,dc,191,52,20,4,3);
        }
      	uiH.drawHours(dc,42,-30,45,-20,uiH.fontHuge245());
    	uiH.drawMinutes(dc,182,45,45,-20,uiH.fontHuge245());
		uiH.drawBottomLeft(dc,145,170,20,uiH.fontSmall());
		uiH.drawBluetoothConnection(dc,140,245);
	}
	
	function draw_venu(dc){
		// uiH.debug = false;
		if(uiH.debug || inLowPower && uiH.canBurn()){
			var step = 4;
			var radX = 104;
			var radY = 54;
			var x = 160;
			var y = 10;
			var xm = x+8;
			var ym = y+130;
			
			var xy = uiH.getAnalogClockPosition(step,System.getClockTime().min,radX,radY);
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
				}
			}
		}else{
			uiH.drawBluetoothConnection(dc,195,350);
		
			var topCenter=uiH.whatToShowAtTop();
			var topRight=uiH.whatToShowAtRight();
	        uiH.drawTopFA(topCenter,dc,195,20,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,170,45,25,0,4,uiH.fontMedium());
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,260,60,25,4,3,uiH.fontMedium());
	        }
	      	uiH.drawHours(dc,60,10,60,-20,uiH.fontHuge245());
	    	uiH.drawMinutes(dc,250,90,60,-20,uiH.fontHuge245());
			uiH.drawBottomLeft(dc,195,230,25,uiH.fontMedium());
		}
		
	}

	function draw_454_454_1(dc){
		if(uiH.debug || inLowPower && uiH.canBurn()){
			var step = 4;
			var radX = 130;
			var radY = 90;
			var x = 200;
			var y = 40;
			var xm = x+8;
			var ym = y+130;
			
			var xy = uiH.getAnalogClockPosition(step,System.getClockTime().min,radX,radY);
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
				}
			}
		}else{
			var xOffset = 30;
			var yOffset = 40;

			uiH.drawBluetoothConnection(dc,195+xOffset,350+yOffset);
		
			var topCenter=uiH.whatToShowAtTop();
			var topRight=uiH.whatToShowAtRight();
	        uiH.drawTopFA(topCenter,dc,195+xOffset,20,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,190+xOffset,45+yOffset,25,0,4,uiH.fontMedium());
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,280+xOffset,60+yOffset,25,4,3,uiH.fontMedium());
	        }
	      	uiH.drawHours(dc,80+xOffset,10+yOffset,60,-20,uiH.fontHuge245());
	    	uiH.drawMinutes(dc,260+xOffset,90+yOffset,60,-20,uiH.fontHuge245());
			uiH.drawBottomLeft(dc,195+xOffset,230+yOffset,25,uiH.fontMedium());
		}
		
	}

	function draw_416_416_1(dc){
		if(uiH.debug || inLowPower && uiH.canBurn()){
			var step = 4;
			var radX = 110;
			var radY = 80;
			var x = 185;
			var y = 30;
			var xm = x+8;
			var ym = y+130;
			
			var xy = uiH.getAnalogClockPosition(step,System.getClockTime().min,radX,radY);
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
				}
			}
		}else{
			var xOffset = 15;
			var yOffset = 30;

			uiH.drawBluetoothConnection(dc,195+xOffset,350+yOffset);
		
			var topCenter=uiH.whatToShowAtTop();
			var topRight=uiH.whatToShowAtRight();
	        uiH.drawTopFA(topCenter,dc,195+xOffset,20,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,190+xOffset,45+yOffset,25,0,4,uiH.fontMedium());
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,280+xOffset,60+yOffset,25,4,3,uiH.fontMedium());
	        }
	      	uiH.drawHours(dc,80+xOffset,10+yOffset,60,-20,uiH.fontHuge245());
	    	uiH.drawMinutes(dc,260+xOffset,90+yOffset,60,-20,uiH.fontHuge245());
			uiH.drawBottomLeft(dc,195+xOffset,230+yOffset,25,uiH.fontMedium());
		}
		
	}

	function drawFonts(dc){
		var x = 0;
		var y = 50;

		// show all months
		for (var index = 1; index <= 12; index++) {
			y = index * 18 + 15;
			x = 50;
			dc.drawText(x,y, uiH.fontSmall_(100), uiH.getMonthName(index), Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x+40,y, uiH.fontSmall_(2), uiH.getMonthName(index), Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x+70,y, uiH.fontSmall_(3), uiH.getMonthName(index), Graphics.TEXT_JUSTIFY_LEFT);	
		}
		
		for (var index = 1; index <= 7; index++) {
			y = index * 18 + 15;
			x = 155;
			dc.drawText(x,y, uiH.fontSmall_(100), uiH.getWeekdayName(index), Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x+30,y, uiH.fontSmall_(2), uiH.getWeekdayName(index), Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x+60,y, uiH.fontSmall_(3), uiH.getWeekdayName(index), Graphics.TEXT_JUSTIFY_LEFT);	
		}

		x = 80;
		y = -10;
		dc.drawText(x,y, uiH.fontSmall_(100), uiH.getMsgs(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getMsgs(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+30, uiH.fontSmall_(3), uiH.getMsgs(), Graphics.TEXT_JUSTIFY_LEFT);
		
		x=155; y= 155;	
		dc.drawText(x,y, uiH.fontSmall_(100), uiH.getCalories(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getCalories(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+30, uiH.fontSmall_(3), uiH.getCalories(), Graphics.TEXT_JUSTIFY_LEFT);

		y = 200;
		x = 145;	
		dc.drawText(x,y, uiH.fontSmall_(3), uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+30, uiH.fontSmall_(100), uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		
		x=-15;y=65;
		dc.drawText(x,y, uiH.fontSmall_(100), uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+30, uiH.fontSmall_(3), uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);

		x=-15;y=105;
		dc.drawText(x,y, uiH.fontSmall_(100), uiH.getSteps(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getSteps(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+30, uiH.fontSmall_(3), uiH.getSteps(), Graphics.TEXT_JUSTIFY_LEFT);

		x=-15;y=150;
		dc.drawText(x,y, uiH.fontSmall_(3), uiH.getFloors(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x,y+15, uiH.fontSmall_(2), uiH.getFloors(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(x+10,y+30, uiH.fontSmall_(100), uiH.getFloors(), Graphics.TEXT_JUSTIFY_LEFT);

	}

    function onUpdate(dc) {
        
        checkPhoneConnectionAndBeep();

        // Set colors based on cached display type
        if (isOledDisplay) {
            uiH.setColorsOled(dc, inLowPower);
            uiH.shortFormat = false;
        } else {
            uiH.setColors(dc);
        }

		if(fontsMode){
			uiH.shortFormat = false;
			drawFonts(dc);
			return;
		}
        
        // Simple switch based on cached device type
        switch(deviceType) {
            case DeviceType.VENU:
                draw_venu(dc);
                break;
            case DeviceType.VENU_454:
                draw_454_454_1(dc);
                break;
            case DeviceType.VENU_416:
                draw_416_416_1(dc);
                break;
            case DeviceType.VIVOACTIVE_HR:
                draw_vivoactiveHR(dc);
                break;
            case DeviceType.FR920XT:
                draw_fr920xt(dc);
                break;
            case DeviceType.FR230_FR235:
                draw_fr230_fr235(dc);
                break;
            case DeviceType.FR45:
                draw_fr45(dc);
                break;
            case DeviceType.FENIX3:
                draw_fenix3(dc);
                break;
            case DeviceType.FR245_FENIX5X:
                draw_fr245_fenix5x(dc);
                break;
            case DeviceType.FENIX6:
                draw_fenix6(dc);
                break;
            case DeviceType.FENIX6XPRO:
                uiH.shortFormat = false;
                draw_fenix6xpro(dc);
                break;
            case DeviceType.VENUSQ:
                draw_venusq(dc);
                break;
            case DeviceType.DEVICE_176:
                draw_176x176x4(dc);
                break;
            case DeviceType.DEVICE_163:
                draw_163x156x4(dc);
                break;
            case DeviceType.DEVICE_166:
                draw_166x166x4(dc);
                break;
            default:
                if(uiH.debug) {
                    System.println("Using fallback for unknown device type: " + deviceType);
                }
                draw_fr230_fr235(dc);
        }
    }

}
