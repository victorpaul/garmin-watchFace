using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	var weatherUtils;
	var inLowPower=false;
	var deviceType = null;
	var isOledDisplay = false;
	var fontsMode = false;

    function initialize() {
        WatchFace.initialize();

        uiH = new helper();
        weatherUtils = new weather();
        uiH.debug = true;
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

	// Devices: vivoactive_hr (148x205x3)
	function draw_148x205x3(dc){
		// Same old-hardware generation as fr920xt (205x148x3): icon bitmaps
		// get an opaque black box behind them, so force the light-fill icon
		// to stay visible against it.
		IconTheme.forceLightIcon = true;

    	var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,88,-5,14,0,6);
  		uiH.drawHours(dc,25,-62,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,75,30,50,0,uiH.fontHuge45());
		
		uiH.drawBluetoothConnectionSmall(dc,10,120);

		uiH.drawBottomLeftLeft(dc,2,140,20,uiH.fontSmall());
		
		
	}

	// Devices: instinct2, instinct2x, instinct3solar45mm, instinctcrossover,
	// instincte45mm (176x176x4)
	function draw_176x176x4(dc) {
		// uiH.debug = true;

		var topRight=uiH.whatToShowAtRight();

    	uiH.drawTopRight(topRight,dc,116,11,14,0,2);
  		uiH.drawHours(dc,30,-65,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,95,10,50,0,uiH.fontHuge45());

		uiH.drawBottomLeft(dc,75,85,20,uiH.fontSmall());

		uiH.drawBluetoothConnectionSmall(dc,102,65);
	}

	// Devices: instinct2s (163x156x4)
	function draw_163x156x4(dc) {
		// uiH.debug = true;
		var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,109,4,14,0,2);
  		uiH.drawHours(dc,25,-69,40,0,uiH.fontHuge45()); //todo, decrease main font
		uiH.drawMinutes(dc,80,-5,50,0,uiH.fontHuge45());
		
		uiH.drawBluetoothConnectionSmall(dc,100,55);

		uiH.drawBottomLeft(dc,70,80,20,uiH.fontSmall());
	}

	
	// Devices: instincte40mm (166x166x4)
	function draw_166x166x4(dc) {
		// uiH.debug = true;
		var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,109,4,14,0,2);
  		uiH.drawHours(dc,25,-69,40,0,uiH.fontHuge45()); //todo, decrease main font
		uiH.drawMinutes(dc,80,5,60,0,uiH.fontHuge45());
		
		uiH.drawBluetoothConnectionSmall(dc,100,55);

		uiH.drawBottomLeft(dc,70,80,20,uiH.fontSmall());
	}
	
	// Devices: fr920xt, vivoactive (205x148x3)
	function draw_205x148x3(dc){
		// This old hardware generation renders icon bitmaps with an opaque
		// black box behind them (confirmed on fr920xt), so force the
		// light-fill icon to stay visible against it.
		IconTheme.forceLightIcon = true;
		// uiH.debug = true;
		var topRight=uiH.whatToShowAtRight();
		
		uiH.drawTopLeft(dc,107,-5);
    	uiH.drawTopRight(topRight,dc,107,13,15,0,1);
  		uiH.drawHours(dc,28,-60,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,125,-30,50,0,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,85,92,19,uiH.fontSmall());
	}
	
	// Devices: fr230, fr235, fr630, fr735xt (215x180x2).
	// Also the default fallback for any unrecognized device/resolution.
	function draw_215x180x2(dc){
		IconTheme.forceLightIcon = true;
		// uiH.debug = true;
		var topRight=uiH.whatToShowAtRight();
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,110,19,15,0,3);
  		uiH.drawHours(dc,35,-45,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,125,3,50,0,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,92,110,21,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,115,170);
	}

	// Devices: none currently — venusq/venusqm are the only 240x240x3 devices
	// in the Connect IQ SDK, but neither is declared in manifest.xml, so this
	// layout cannot be built or launched for any supported device right now.
	function draw_240x240x3(dc){
		// uiH.debug = true;
		var topRight=uiH.whatToShowAtRight();
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,140,19,15,0,3);
  		
		uiH.drawHours(dc,45,-65,50,0,uiH.fontHuge245());
		uiH.drawMinutes(dc,150,10,50,0,uiH.fontHuge245());
		
		uiH.drawBottomLeft(dc,110,145,21,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,90,220);
	}
	
	// Devices: d2bravo, d2bravo_titanium, fenix3, fenix3_hr, fenix5s,
	// fenixchronos, fr255s, fr255sm, legacyherocaptainmarvel, legacysagarey,
	// vivoactive4s (218x218x1)
	function draw_218x218x1(dc){
		//fenix 3 has svg issue
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(topRight,dc,118,28,20,0,3);
      	uiH.drawHours(dc,35,-15,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,130,35,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,98,140,19,uiH.fontSmall());
		uiH.drawBluetoothConnectionSmall(dc,210,110);
	}
	
	// Devices: fr45, fr55, garminswim2 (208x208x1)
	function draw_208x208x1(dc){
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,8);
        uiH.drawTopRight(topRight,dc,115,25,17,0,3);
      	uiH.drawHours(dc,35,-20,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,121,30,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,93,136,17,uiH.fontSmall());
		
		uiH.drawBluetoothConnectionSmall(dc,199,108);
	}
	
	// Devices (240x240x1, largest group - 36 devices): approachs60, d2charlie,
	// d2delta, d2deltapx, d2deltas, descentmk1, descentmk2s, fenix5, fenix5plus,
	// fenix5splus, fenix5x, fenix5xplus, fenix6s, fenix6spro, fenix7s,
	// fenix7spro, fr245, fr245m, fr645, fr645m, fr745, fr935, fr945, fr945lte,
	// marqadventurer, marqathlete, marqaviator, marqcaptain, marqcommander,
	// marqdriver, marqexpedition, marqgolfer, vivoactive3, vivoactive3d,
	// vivoactive3m, vivoactive3mlte
	function draw_240x240x1(dc) {
		var topCenter=uiH.whatToShowAtTop();
		var topRight=uiH.whatToShowAtRight();

        uiH.drawTopFA(topCenter,dc,120,5,uiH.fontSmall(),Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,125,25,20,0,3);
      	uiH.drawHours(dc,40,-40,45,-20,uiH.fontHuge245());
    	uiH.drawMinutes(dc,145,20,45,-20,uiH.fontHuge245());
		uiH.drawBottomLeft(dc,108,152,20,uiH.fontSmall());
		
		uiH.drawBluetoothConnection(dc,135,84);
	}
		
	// Devices: approachs62, fenix6, fenix6pro, fenix7, fenix7pro,
	// fenix7pronowifi, fenix8solar47mm, fr255, fr255m, fr955,
	// legacyherofirstavenger, legacysagadarthvader, vivoactive4 (260x260x1)
	function draw_260x260x1(dc){
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
	
	// Devices: descentmk2, enduro, fenix6xpro, fenix7x, fenix7xpro,
	// fenix7xpronowifi, fenix8solar51mm (280x280x1)
	function draw_280x280x1(dc){
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
	
	// Devices: approachs50, approachs7042mm, d2air, epix2pro42mm, fr165,
	// fr165m, fr265s, marq2, marq2aviator, venu, venud, vivoactive5,
	// vivoactive6 (390x390x1, plus fr265s at 360x360x1)
	function draw_390x390x1(dc){
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

	// Devices: approachs7047mm, epix2pro51mm, fenix847mm, fr965, d2mach2, d2mach2pro (454x454x1)
	function draw_454x454x1(dc){
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

	// Devices: d2airx10, d2mach1, epix2, epix2pro47mm, fenix843mm, fenixe,
	// fr265, venu2 (416x416x1)
	function draw_416x416x1(dc){
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

	// Devices: venux1 (448x486x3, rectangular AMOLED)
	function draw_448x486x3(dc){
		if(uiH.debug || inLowPower && uiH.canBurn()){
			var step = 4;
			var radX = 130;
			var radY = 100;
			var x = 205;
			var y = 55;
			var xm = x+8;
			var ym = y+150;

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
			var yOffset = 75;

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

        uiH.beepService.checkPhoneConnectionAndBeep();

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
                draw_390x390x1(dc);
                break;
            case DeviceType.VENU_454:
                draw_454x454x1(dc);
                break;
            case DeviceType.VENU_416:
                draw_416x416x1(dc);
                break;
            case DeviceType.VIVOACTIVE_HR:
                draw_148x205x3(dc);
                break;
            case DeviceType.FR920XT:
                draw_205x148x3(dc);
                break;
            case DeviceType.FR230_FR235:
                draw_215x180x2(dc);
                break;
            case DeviceType.FR45:
                draw_208x208x1(dc);
                break;
            case DeviceType.FENIX3:
                draw_218x218x1(dc);
                break;
            case DeviceType.FR245_FENIX5X:
                draw_240x240x1(dc);
                break;
            case DeviceType.FENIX6:
                draw_260x260x1(dc);
                break;
            case DeviceType.FENIX6XPRO:
                uiH.shortFormat = false;
                draw_280x280x1(dc);
                break;
            case DeviceType.VENUSQ:
                draw_240x240x3(dc);
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
            case DeviceType.VENU_X1:
                draw_448x486x3(dc);
                break;
            default:
                if(uiH.debug) {
                    System.println("Using fallback for unknown device type: " + deviceType);
                }
                draw_215x180x2(dc);
        }
    }

}
