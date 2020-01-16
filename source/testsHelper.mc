using Toybox.Test;

class HelperTests {

	(:test)
	function success_draw_top_line(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawTopFA(1,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(2,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(3,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(4,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(5,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(6,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(7,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(8,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(9,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(10,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	uiH.drawTopFA(11,dc,120,5,uiH.fontMedium,Graphics.TEXT_JUSTIFY_CENTER);
    	
    	return true;
	}
	
	(:test)
	function success_draw_empty_top_right_block(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawTopRight(1,dc,88,-5,14,3);
    	uiH.drawTopRight(2,dc,88,-5,14,3);
    	uiH.drawTopRight(3,dc,88,-5,14,3);
    	uiH.drawTopRight(4,dc,88,-5,14,3);
    	
//    	logger.debug(dc.calls);
//    	
//    	Test.assertEqual("drawText(88,-5,text,2)",dc.calls[0][0]);
//    	Test.assertEqual("drawText(88,9,text,2)",dc.calls[1][0]);
//    	Test.assertEqual("drawText(88,23,text,2)",dc.calls[2][0]);
//    	
//    	Test.assertEqual(3,dc.calls.size());	
    	return true;
	}
	
	(:test)
	function success_draw_bottom_line(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawBottomLineByOption(dc,88,-5,1);
    	uiH.drawBottomLineByOption(dc,88,-5,2);
    	uiH.drawBottomLineByOption(dc,88,-5,3);
    	uiH.drawBottomLineByOption(dc,88,-5,4);    		
    	uiH.drawBottomLineByOption(dc,88,-5,5);
    	uiH.drawBottomLineByOption(dc,88,-5,6);
    	return true;
	}
	

}	