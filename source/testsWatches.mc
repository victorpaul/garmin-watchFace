using Toybox.Test;

class phoneBatteryIQViewTest {

	(:test)
	function success_drawTopRight_block_without_hr(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawTopRight(dc,88,-5,14,3,false);
    	
    	logger.debug(dc.calls);
    	
    	Test.assertEqual("drawText(88,-5,text,2)",dc.calls[0][0]);
    	Test.assertEqual("drawText(88,9,text,2)",dc.calls[1][0]);
    	Test.assertEqual("drawText(88,23,text,2)",dc.calls[2][0]);
    	
    	
    	return true;
	}
	
//	(:test)
//	function draw_fr920xt(logger){
//		uiH.drawTopLeft(dc,107,-5);
//    	uiH.drawTopRight(dc,107,13,15,1,false);
//  		uiH.drawHours(dc,28,-32,40,0);
//		uiH.drawMinutes(dc,125,3,50,0);
//		uiH.drawBottomLeft(dc,85,100,14,false);
//	}
//	
//	(:test)
//	function draw_fr230_fr235(dc){
//      	uiH.drawTopLeft(dc,107,0);
//    	uiH.drawTopRight(dc,110,19,15,1,true);
//  		uiH.drawHours(dc,35,-20,40,0);
//		uiH.drawMinutes(dc,130,25,50,0);
//		uiH.drawBottomLeft(dc,92,120,18,false);
//	}
//	
//	(:test)
//	function success_draw_fenix3(logger){
//        uiH.drawTop(dc,110,5);
//        uiH.drawTopRight(dc,118,28,20,3,false);
//      	uiH.drawHours(dc,35,-2,45,0);
//    	uiH.drawMinutes(dc,130,75,45,-20);
//		uiH.drawBottomLeft(dc,95,135,16,true);
//	}
//	
//	(:test)
//	function success_draw_fr45(logger){
//        uiH.drawTop(dc,110,5);
//        uiH.drawTopRight(dc,115,25,20,2,true);
//      	uiH.drawHours(dc,35,-4,45,0);
//    	uiH.drawMinutes(dc,121,70,45,-20);
//		uiH.drawBottomLeft(dc,93,136,16,false);
//	}
//	
//	(:test)
//	function success_draw_fr245_fenix5x(logger) {	
//        uiH.drawTopFA(dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
//        uiH.drawTopRight(dc,125,35,20,3,false);
//      	uiH.drawHours(dc,40,10,45,0);
//    	uiH.drawMinutes(dc,145,80,45,-20);
//		uiH.drawBottomLeft(dc,108,155,17,true);
//	}
//		
//	(:test)
//	function success_draw_fenix6(logger){        
//        uiH.drawTopFA(dc,130,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
//        uiH.drawTopRight(dc,125,40,20,4,false);
//      	uiH.drawHours(dc,45,25,45,0);
//    	uiH.drawMinutes(dc,165,98, 45,-20);
//		uiH.drawBottomLeft(dc,125,175,17,true);
//	}
//	
//	(:test)
//	function success_draw_fenix6xpro(logger){        
//        uiH.drawTopFA(dc,125,10,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
//        uiH.drawTopRight(dc,140,40,20,5,false);
//      	uiH.drawHours(dc,45,15,45,0);
//    	uiH.drawMinutes(dc,185,120,45,-20);
//		uiH.drawBottomLeft(dc,145,170,17,true);
//	}

}
