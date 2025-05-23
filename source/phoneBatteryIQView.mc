using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	var inLowPower=false;
	
    function initialize() {
        WatchFace.initialize();
        
        uiH = new helper();
        
        uiH.debug = false;
		uiH.debugDate = false;
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

// 	function draw_venu2(dc){
// //		uiH.debug = true;
// 		if(uiH.debug || inLowPower && uiH.canBurn()){
// 			var step = 4;
// 			var radX = 114;
// 			var radY = 64;
// 			var x = 190;
// 			var y = -18;
// 			var xm = x+8;
// 			var ym = y+130;
			
// 			var xy = uiH.getAnalogClockPosition(step,System.getClockTime().min,radX,radY);
// 			uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
// 			uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
// 			if(uiH.debug){
// 				for(var m=0; m<60;m++){
// 					xy = uiH.getAnalogClockPosition(step,m,radX,radY);
// 					uiH.drawHours(dc,x+xy[0],y+xy[1],45,0,uiH.fontHuge45());
// 					uiH.drawMinutes(dc,xm+xy[0],ym+xy[1],40,0,uiH.fontHuge45());
// 				}
// 			}
// 		}else{
// 			uiH.drawBluetoothConnection(dc,195,350);
		
// 			var topCenter=uiH.whatToShowAtTop();
// 			var topRight=uiH.whatToShowAtRight();
// 	        uiH.drawTopFA(topCenter,dc,195,20,uiH.fontMedium(),Graphics.TEXT_JUSTIFY_CENTER);
	        
// 	        uiH.drawTopRightFont(topRight,dc,190,45,25,0,4,uiH.fontMedium());
// 	        if(topRight==1){
// 	        	uiH.drawTopRightFont(topRight,dc,280,60,25,4,3,uiH.fontMedium());
// 	        }
// 	      	uiH.drawHours(dc,80,10,60,-20,uiH.fontHuge245());
// 	    	uiH.drawMinutes(dc,260,90,60,-20,uiH.fontHuge245());
// 			uiH.drawBottomLeft(dc,195,230,25,uiH.fontMedium());
// 		}
		
// 	}
	
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

		if(uiH.ifScreen(390,390,1) || uiH.ifScreen(360,360,1)){
			uiH.setColorsOled(dc,inLowPower);
			uiH.shortFormat = false;
			draw_venu(dc);	
			return;
		}

		
		if(uiH.ifScreen(454,454,1)){
			uiH.setColorsOled(dc,inLowPower);
			uiH.shortFormat = false;
			draw_454_454_1(dc);	
			return;
		}

		if(uiH.ifScreen(416,416,1)){
			uiH.setColorsOled(dc,inLowPower);
			uiH.shortFormat = false;
			draw_416_416_1(dc);	
			return;
		}
		
		uiH.setColors(dc);
		if(uiH.ifScreen(148,205,3)){
			draw_vivoactiveHR(dc);
			return;
		}
		if(uiH.ifScreen(205,148,3)){
			draw_fr920xt(dc);
			return;
		}		
		if(uiH.ifScreen(215,180,2)){
			draw_fr230_fr235(dc);
			return;
		}
		if(uiH.ifScreen(208,208,1)){
			draw_fr45(dc);	
			return;
		}
		if(uiH.ifScreen(218,218,1)){
			draw_fenix3(dc);	
			return;
		}
		if(uiH.ifScreen(240,240,1)){
			draw_fr245_fenix5x(dc);	 // most popular size
			return;
		}
		if(uiH.ifScreen(260,260,1)){
			draw_fenix6(dc);	
			return;
		}
		if(uiH.ifScreen(280,280,1)){
			uiH.shortFormat = false;
			draw_fenix6xpro(dc);	
			return;
		}

		if(uiH.ifScreen(240,240,3)){
			draw_venusq(dc);
			return;
		}

		if(uiH.ifScreen(176,176,4)){
			draw_176x176x4(dc);
			return;
		}

		if(uiH.ifScreen(163,156,4)){
			draw_163x156x4(dc);
			return;
		}
		if(uiH.ifScreen(166,166,4)){
			draw_166x166x4(dc);
			return;
		}
		

		if(uiH.debug) {
			System.println("Not found");
		}

		// nope: swim2, venu
		draw_fr230_fr235(dc);
    }

}
