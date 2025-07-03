using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	var inLowPower=false;
	
    // New variables for settings
    var mWhatToShowAtTop;
    var mWhatToShowAtRight;
    var mShowBottomLeft;
    var mWhatToShowAtBottomLeft;
    var mWhatToShowAtBottomLeft2;
    var mWhatToShowAtBottomLeft3;
    var mUseOldFont;
    var mBTConnection;
    var mFont;
    var mFgColor;
    var mBgColor;

    // New variables for fonts
    var mFontHuge245;
    var mFontHuge45;
    var mFontMedium;
    var mFontSmall;
    var mFontIcons;
    var mFontSmallIcons;

    // Device profile
    var mDeviceProfile;

    const PROFILE_VIVOACTIVE_HR = "vivoactive_hr";
    const PROFILE_FR920XT = "fr920xt";
    const PROFILE_FR230_FR235 = "fr230_235";
    const PROFILE_VENUSQ = "venusq";
    const PROFILE_FENIX3 = "fenix3";
    const PROFILE_FR45 = "fr45";
    const PROFILE_FR245_FENIX5X = "fr245_fenix5x";
    const PROFILE_FENIX6 = "fenix6";
    const PROFILE_FENIX6XPRO = "fenix6xpro";
    const PROFILE_VENU = "venu";
    const PROFILE_454_454 = "454_454";
    const PROFILE_416_416 = "416_416";
    const PROFILE_176_176 = "176_176";
    const PROFILE_163_156 = "163_156";
    const PROFILE_166_166 = "166_166";
    const PROFILE_DEFAULT = "default";
	
    function initialize() {
        WatchFace.initialize();
        
        uiH = new helper(self);
        
        uiH.debug = false;
		uiH.debugDate = false;

        loadSettings();
        loadFonts(); 
        determineDeviceProfile();
    }

    function onSettingsChanged() {
        loadSettings();
        loadFonts();
        WatchUi.requestUpdate();
    }

    function loadSettings() {
        mWhatToShowAtTop = Application.getApp().getProperty("WhatToShowAtTop");
        mWhatToShowAtRight = Application.getApp().getProperty("WhatToShowAtRight");
        mShowBottomLeft = Application.getApp().getProperty("ShowBottomLeft");
        mWhatToShowAtBottomLeft = Application.getApp().getProperty("WhatToShowAtBottomLeft");
        mWhatToShowAtBottomLeft2 = Application.getApp().getProperty("WhatToShowAtBottomLeft2");
        mWhatToShowAtBottomLeft3 = Application.getApp().getProperty("WhatToShowAtBottomLeft3");
        mUseOldFont = Application.getApp().getProperty("UseOldFont");
        mBTConnection = Application.getApp().getProperty("BTCOnnection");
        mFont = Application.getApp().getProperty("Font");
        mFgColor = Application.getApp().getProperty("ForegroundColor");
        mBgColor = Application.getApp().getProperty("BackgroundColor");
    }

    function loadFonts() {
        if (mUseOldFont) {
            mFontHuge45 = WatchUi.loadResource(Rez.Fonts.fntHugeOld);
            mFontHuge245 = WatchUi.loadResource(Rez.Fonts.fntHugeOld);
        } else {
            mFontHuge45 = WatchUi.loadResource(Rez.Fonts.fntHuge45);
            mFontHuge245 = WatchUi.loadResource(Rez.Fonts.fntHuge);
        }

        switch(mFont){
            case 2:
                mFontMedium = WatchUi.loadResource(Rez.Fonts.mediumJannScript);
                mFontSmall = WatchUi.loadResource(Rez.Fonts.smallJannScript);
                break;
            case 3:
                mFontMedium = WatchUi.loadResource(Rez.Fonts.mediumStiffBrush);
                mFontSmall = WatchUi.loadResource(Rez.Fonts.smallStiffBrush);
                break;
            default:
                mFontMedium = WatchUi.loadResource(Rez.Fonts.fntMedium);
                mFontSmall = WatchUi.loadResource(Rez.Fonts.fntSmall);
                break;
        }
        
        mFontIcons = WatchUi.loadResource(Rez.Fonts.icons);
        mFontSmallIcons = WatchUi.loadResource(Rez.Fonts.smallicons);
    }

    function determineDeviceProfile() {
        var width = System.getDeviceSettings().screenWidth;
        var height = System.getDeviceSettings().screenHeight;
        var shape = System.getDeviceSettings().screenShape;

        if (width == 148 && height == 205 && shape == 3) {
            mDeviceProfile = PROFILE_VIVOACTIVE_HR;
        } else if (width == 205 && height == 148 && shape == 3) {
            mDeviceProfile = PROFILE_FR920XT;
        } else if (width == 215 && height == 180 && shape == 2) {
            mDeviceProfile = PROFILE_FR230_FR235;
        } else if (width == 208 && height == 208 && shape == 1) {
            mDeviceProfile = PROFILE_FR45;
        } else if (width == 218 && height == 218 && shape == 1) {
            mDeviceProfile = PROFILE_FENIX3;
        } else if (width == 240 && height == 240 && shape == 1) {
            mDeviceProfile = PROFILE_FR245_FENIX5X;
        } else if (width == 260 && height == 260 && shape == 1) {
            mDeviceProfile = PROFILE_FENIX6;
        } else if (width == 280 && height == 280 && shape == 1) {
            mDeviceProfile = PROFILE_FENIX6XPRO;
        } else if ( (width == 390 && height == 390 && shape == 1) || (width == 360 && height == 360 && shape == 1) ) {
            mDeviceProfile = PROFILE_VENU;
        } else if (width == 454 && height == 454 && shape == 1) {
            mDeviceProfile = PROFILE_454_454;
        } else if (width == 416 && height == 416 && shape == 1) {
            mDeviceProfile = PROFILE_416_416;
        } else if (width == 240 && height == 240 && shape == 3) {
            mDeviceProfile = PROFILE_VENUSQ;
        } else if (width == 176 && height == 176 && shape == 4) {
            mDeviceProfile = PROFILE_176_176;
        } else if (width == 163 && height == 156 && shape == 4) {
            mDeviceProfile = PROFILE_163_156;
        } else if (width == 166 && height == 166 && shape == 4) {
            mDeviceProfile = PROFILE_166_166;
        } else {
            mDeviceProfile = PROFILE_DEFAULT;
        }
    }
    
    function onExitSleep() {
        inLowPower=false;
    	WatchUi.requestUpdate(); 
    }

    function onEnterSleep() {
    	inLowPower=true;
    	WatchUi.requestUpdate(); 
    }
	
	function draw_vivoactiveHR(dc){
    	var topRight=mWhatToShowAtRight;
    	
    	uiH.drawTopRight(topRight,dc,88,-5,14,0,6);
  		uiH.drawHours(dc,25,-62,40,0,mFontHuge45);
		uiH.drawMinutes(dc,70,30,50,0,mFontHuge45);
		
		dc.drawText(2,130, mFontSmall,uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(2,150, mFontSmall,uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		
		uiH.drawBluetoothConnectionSmall(dc,12,178);
	}

	function draw_176x176x4(dc) {
		var topRight=mWhatToShowAtRight;
    	
    	uiH.drawTopRight(topRight,dc,116,11,14,0,2);
  		uiH.drawHours(dc,30,-65,40,0,mFontHuge45);
		uiH.drawMinutes(dc,95,10,50,0,mFontHuge45);
		
		
		dc.drawText(10,95, mFontSmall,uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(10,115, mFontSmall,uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,50,137);
	}

	function draw_163x156x4(dc) {
		var topRight=mWhatToShowAtRight;
    	
    	uiH.drawTopRight(topRight,dc,109,4,14,0,2);
  		uiH.drawHours(dc,25,-69,40,0,mFontHuge45);
		uiH.drawMinutes(dc,80,-5,50,0,mFontHuge45);
		
		
		dc.drawText(5,80, mFontSmall,uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(5,100, mFontSmall,uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,40,120);
	}

	
	function draw_166x166x4(dc) {
		var topRight=mWhatToShowAtRight;
    	
    	uiH.drawTopRight(topRight,dc,112,4,14,0,2);
  		uiH.drawHours(dc,25,-65,40,0,mFontHuge45);
		uiH.drawMinutes(dc,87,-5,50,0,mFontHuge45);
		
		
		dc.drawText(5,95, mFontSmall,uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(5,115, mFontSmall,uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		uiH.drawBluetoothConnectionSmall(dc,40,135);
	}
	
	function draw_fr920xt(dc){
		var topRight=mWhatToShowAtRight;
		
		uiH.drawTopLeft(dc,107,-5);
    	uiH.drawTopRight(topRight,dc,107,13,15,0,1);
  		uiH.drawHours(dc,28,-60,40,0,mFontHuge45);
		uiH.drawMinutes(dc,125,-30,50,0,mFontHuge45);
		uiH.drawBottomLeft(dc,85,100,14,mFontSmall);
	}
	
	function draw_fr230_fr235(dc){
		var topRight=mWhatToShowAtRight;
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,110,19,15,0,3);
  		uiH.drawHours(dc,35,-35,40,0,mFontHuge45);
		uiH.drawMinutes(dc,125,3,50,0,mFontHuge45);
		uiH.drawBottomLeft(dc,92,120,18,mFontSmall);
		uiH.drawBluetoothConnectionSmall(dc,135,152);
	}

	function draw_venusq(dc){
		var topRight=mWhatToShowAtRight;
		
      	uiH.drawTopLeft(dc,90,0);
    	uiH.drawTopRight(topRight,dc,110,19,15,0,3);
  		uiH.drawHours(dc,35,-35,40,0,mFontHuge45);
		uiH.drawMinutes(dc,150,3,50,0,mFontHuge45);
		uiH.drawBottomLeft(dc,92,120,18,mFontSmall);
		uiH.drawBluetoothConnectionSmall(dc,135,152);
	}
	
	function draw_fenix3(dc){
        var topRight=mWhatToShowAtRight;
        
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(topRight,dc,118,28,20,0,3);
      	uiH.drawHours(dc,35,-15,45,-10,mFontHuge45);
    	uiH.drawMinutes(dc,130,35,45,-10,mFontHuge45);
		uiH.drawBottomLeft(dc,98,140,19,mFontSmall);
		uiH.drawBluetoothConnectionSmall(dc,210,110);
	}
	
	function draw_fr45(dc){
        var topRight=mWhatToShowAtRight;
        
        uiH.drawTop(dc,110,8);
        uiH.drawTopRight(topRight,dc,115,25,17,0,3);
      	uiH.drawHours(dc,35,-20,45,-10,mFontHuge45);
    	uiH.drawMinutes(dc,121,30,45,-10,mFontHuge45);
		uiH.drawBottomLeft(dc,93,136,17,mFontSmall);
		
		uiH.drawBluetoothConnectionSmall(dc,199,108);
	}
	
	function draw_fr245_fenix5x(dc) {
		var topCenter=mWhatToShowAtTop;
		var topRight=mWhatToShowAtRight;

        uiH.drawTopFA(topCenter,dc,120,5,mFontSmall,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,125,25,20,0,3);
      	uiH.drawHours(dc,40,-40,45,-20,mFontHuge245);
    	uiH.drawMinutes(dc,145,20,45,-20,mFontHuge245);
		uiH.drawBottomLeft(dc,108,152,20,mFontSmall);
		
		uiH.drawBluetoothConnection(dc,135,84);
	}
		
	function draw_fenix6(dc){
		var topCenter=mWhatToShowAtTop;
		var topRight=mWhatToShowAtRight;
	
        uiH.drawTopFA(topCenter,dc,130,5,mFontMedium,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,115,32,19,0,4);
        if(topRight==1){
        	uiH.drawTopRight(topRight,dc,180,50,19,4,3);
        }
        
      	uiH.drawHours(dc,35,-20,45,-20,mFontHuge245);
    	uiH.drawMinutes(dc,160,37, 45,-20,mFontHuge245);
		uiH.drawBottomLeft(dc,125,165,19,mFontSmall);
		
		uiH.drawBluetoothConnection(dc,120,225);
	}
	
	function draw_fenix6xpro(dc){
		var topCenter=mWhatToShowAtTop;
		var topRight=mWhatToShowAtRight;
        uiH.drawTopFA(topCenter,dc,133,10,mFontMedium,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,127,40,20,0,4);
        if(topRight==1){
        	uiH.drawTopRight(topRight,dc,191,52,20,4,3);
        }
      	uiH.drawHours(dc,42,-30,45,-20,mFontHuge245);
    	uiH.drawMinutes(dc,182,45,45,-20,mFontHuge245);
		uiH.drawBottomLeft(dc,145,170,20,mFontSmall);
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
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
				}
			}
		}else{
			uiH.drawBluetoothConnection(dc,195,350);
		
			var topCenter=mWhatToShowAtTop;
			var topRight=mWhatToShowAtRight;
	        uiH.drawTopFA(topCenter,dc,195,20,mFontMedium,Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,170,45,25,0,4,mFontMedium);
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,260,60,25,4,3,mFontMedium);
	        }
	      	uiH.drawHours(dc,60,10,60,-20,mFontHuge245);
	    	uiH.drawMinutes(dc,250,90,60,-20,mFontHuge245);
			uiH.drawBottomLeft(dc,195,230,25,mFontMedium);
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
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
				}
			}
		}else{
			var xOffset = 30;
			var yOffset = 40;

			uiH.drawBluetoothConnection(dc,195+xOffset,350+yOffset);
		
			var topCenter=mWhatToShowAtTop;
			var topRight=mWhatToShowAtRight;
	        uiH.drawTopFA(topCenter,dc,195+xOffset,20,mFontMedium,Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,190+xOffset,45+yOffset,25,0,4,mFontMedium);
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,280+xOffset,60+yOffset,25,4,3,mFontMedium);
	        }
	      	uiH.drawHours(dc,80+xOffset,10+yOffset,60,-20,mFontHuge245);
	    	uiH.drawMinutes(dc,260+xOffset,90+yOffset,60,-20,mFontHuge245);
			uiH.drawBottomLeft(dc,195+xOffset,230+yOffset,25,mFontMedium);
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
			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
			if(uiH.debug){
				for(var m=0; m<60;m++){
					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,mFontHuge45);
					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,mFontHuge45);
				}
			}
		}else{
			var xOffset = 15;
			var yOffset = 30;

			uiH.drawBluetoothConnection(dc,195+xOffset,350+yOffset);
		
			var topCenter=mWhatToShowAtTop;
			var topRight=mWhatToShowAtRight;
	        uiH.drawTopFA(topCenter,dc,195+xOffset,20,mFontMedium,Graphics.TEXT_JUSTIFY_CENTER);
	        
	        uiH.drawTopRightFont(topRight,dc,190+xOffset,45+yOffset,25,0,4,mFontMedium);
	        if(topRight==1){
	        	uiH.drawTopRightFont(topRight,dc,280+xOffset,60+yOffset,25,4,3,mFontMedium);
	        }
	      	uiH.drawHours(dc,80+xOffset,10+yOffset,60,-20,mFontHuge245);
	    	uiH.drawMinutes(dc,260+xOffset,90+yOffset,60,-20,mFontHuge245);
			uiH.drawBottomLeft(dc,195+xOffset,230+yOffset,25,mFontMedium);
		}
	}

    // Update the view
    function onUpdate(dc) {
		if(uiH.debug) {
			System.println(
				Lang.format("$1$ x $2$ on $3$",[
					System.getDeviceSettings().screenWidth, 
					System.getDeviceSettings().screenHeight,
					System.getDeviceSettings().screenShape ])
			);
		}

        if (mDeviceProfile == PROFILE_VENU || mDeviceProfile == PROFILE_454_454 || mDeviceProfile == PROFILE_416_416) {
            uiH.setColorsOled(dc, inLowPower);
            uiH.shortFormat = false;
        } else {
            uiH.setColors(dc);
        }

        switch (mDeviceProfile) {
            case PROFILE_VIVOACTIVE_HR:
                draw_vivoactiveHR(dc);
                break;
            case PROFILE_FR920XT:
                draw_fr920xt(dc);
                break;
            case PROFILE_FR230_FR235:
                draw_fr230_fr235(dc);
                break;
            case PROFILE_FR45:
                draw_fr45(dc);
                break;
            case PROFILE_FENIX3:
                draw_fenix3(dc);
                break;
            case PROFILE_FR245_FENIX5X:
                draw_fr245_fenix5x(dc);
                break;
            case PROFILE_FENIX6:
                draw_fenix6(dc);
                break;
            case PROFILE_FENIX6XPRO:
                draw_fenix6xpro(dc);
                break;
            case PROFILE_VENU:
                draw_venu(dc);
                break;
            case PROFILE_454_454:
                draw_454_454_1(dc);
                break;
            case PROFILE_416_416:
                draw_416_416_1(dc);
                break;
            case PROFILE_VENUSQ:
                draw_venusq(dc);
                break;
            case PROFILE_176_176:
                draw_176x176x4(dc);
                break;
            case PROFILE_163_156:
                draw_163x156x4(dc);
                break;
            case PROFILE_166_166:
                draw_166x166x4(dc);
                break;
            default:
                if(uiH.debug) {
                    System.println("Not found, using default");
                }
                draw_fr230_fr235(dc);
                break;
        }
    }

}
