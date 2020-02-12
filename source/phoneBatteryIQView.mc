using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	
    function initialize() {
        WatchFace.initialize();
        
        uiH = new helper();
        
        uiH.debug = true;
		uiH.debugDate = false;
    }
	
	function draw_vivoactiveHR(dc){
    	var topRight=uiH.whatToShowAtRight();
    	
    	uiH.drawTopRight(topRight,dc,88,-5,14,0,6);
  		uiH.drawHours(dc,25,-62,40,0,uiH.fontHuge45());
		uiH.drawMinutes(dc,70,30,50,0,uiH.fontHuge45());
		
		dc.drawText(2,130, uiH.fontSmall(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(2,150, uiH.fontSmall(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);    	
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
	}
	
	function draw_fenix3(dc){
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(topRight,dc,118,28,20,0,3);
      	uiH.drawHours(dc,35,-15,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,130,35,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,98,140,19,uiH.fontSmall());
	}
	
	function draw_fr45(dc){
        var topRight=uiH.whatToShowAtRight();
        
        uiH.drawTop(dc,110,8);
        uiH.drawTopRight(topRight,dc,115,25,17,0,3);
      	uiH.drawHours(dc,35,-20,45,-10,uiH.fontHuge45());
    	uiH.drawMinutes(dc,121,30,45,-10,uiH.fontHuge45());
		uiH.drawBottomLeft(dc,93,136,17,uiH.fontSmall());
	}
	
	function draw_fr245_fenix5x(dc) {
		var topCenter=uiH.whatToShowAtTop();
		var topRight=uiH.whatToShowAtRight();

        uiH.drawTopFA(topCenter,dc,120,5,uiH.fontSmall(),Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(topRight,dc,125,25,20,0,3);
      	uiH.drawHours(dc,40,-40,45,-20,uiH.fontHuge245());
    	uiH.drawMinutes(dc,145,20,45,-20,uiH.fontHuge245());
		uiH.drawBottomLeft(dc,108,152,20,uiH.fontSmall());
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
	}
	
    // Update the view
    function onUpdate(dc) {
    	uiH.setColors(dc);

//		System.println(System.getDeviceSettings().screenWidth);
//		System.println(System.getDeviceSettings().screenHeight);
//		System.println(System.getDeviceSettings().screenShape);
		
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

		// nope: swim2, venu
		draw_fr230_fr235(dc);
    }

}
