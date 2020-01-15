using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class phoneBatteryIQView extends WatchUi.WatchFace {

	var uiH;
	
    function initialize() {
        WatchFace.initialize();
        
        uiH = new helper();
        
        uiH.debug = false;
		uiH.debugDate = false;
    }
	
	function draw_vivoactiveHR(dc){
    	uiH.drawTopRight(dc,88,-5,14,6);
  		uiH.drawHours(dc,25,-32,40,0);
		uiH.drawMinutes(dc,70,60,50,0);
		
		dc.drawText(2,130, uiH.getSmallFont(),uiH.getBattery(), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(2,150, uiH.getSmallFont(),uiH.getHR(), Graphics.TEXT_JUSTIFY_LEFT);    	
	}
	
	function draw_fr920xt(dc){
		uiH.drawTopLeft(dc,107,-5);
    	uiH.drawTopRight(dc,107,13,15,1);
  		uiH.drawHours(dc,28,-32,40,0);
		uiH.drawMinutes(dc,125,3,50,0);
		uiH.drawBottomLeft(dc,85,100,14);
	}
	
	function draw_fr230_fr235(dc){
      	uiH.drawTopLeft(dc,105,0);
    	uiH.drawTopRight(dc,110,19,15,2);
  		uiH.drawHours(dc,35,-20,40,0);
		uiH.drawMinutes(dc,130,25,50,0);
		uiH.drawBottomLeft(dc,92,120,18);
	}
	
	function draw_fenix3(dc){
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(dc,118,28,20,3);
      	uiH.drawHours(dc,35,-2,45,0);
    	uiH.drawMinutes(dc,130,75,45,-20);
		uiH.drawBottomLeft(dc,98,140,19);
	}
	
	function draw_fr45(dc){	       
        uiH.drawTop(dc,110,5);
        uiH.drawTopRight(dc,115,25,20,3);
      	uiH.drawHours(dc,35,-4,45,0);
    	uiH.drawMinutes(dc,121,70,45,-20);
		uiH.drawBottomLeft(dc,93,136,16);
	}
	
	function draw_fr245_fenix5x(dc) {	
        uiH.drawTopFA(dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(dc,125,35,20,3);
      	uiH.drawHours(dc,40,10,45,0);
    	uiH.drawMinutes(dc,145,80,45,-20);
		uiH.drawBottomLeft(dc,108,155,19);
	}
		
	function draw_fenix6(dc){
        uiH.drawTopFA(dc,130,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(dc,125,40,20,4);
      	uiH.drawHours(dc,45,25,45,0);
    	uiH.drawMinutes(dc,165,98, 45,-20);
		uiH.drawBottomLeft(dc,125,175,19);
	}
	
	function draw_fenix6xpro(dc){        
        uiH.drawTopFA(dc,125,10,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
        uiH.drawTopRight(dc,140,40,20,5);
      	uiH.drawHours(dc,45,15,45,0);
    	uiH.drawMinutes(dc,185,120,45,-20);
		uiH.drawBottomLeft(dc,145,170,19);
	}
	
    // Update the view
    function onUpdate(dc) {
    	uiH.setColors(dc);

//		System.println(System.getDeviceSettings().screenWidth);
//		System.println(System.getDeviceSettings().screenHeight);
//		System.println(System.getDeviceSettings().screenShape);

//		var isInfoTop = uiH.showDays();	
//		var isDate = uiH.showMonthYear();	
//		var isInfoBottom = uiH.showBottomLeft();
//		var option1 = uiH.whatToShowAtBottomLeft();	
//		var option2 = uiH.whatToShowAtBottomLeft2();	
//		var option3 = uiH.whatToShowAtBottomLeft3();
		
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
			draw_fenix6xpro(dc);	
			return;
		}

		// nope: swim2, venu
		draw_fr230_fr235(dc);
    }

}
