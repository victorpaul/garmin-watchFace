using Toybox.Test;

class HelperTests {

	(:test)
	function success_pop_calendar_on_a_day_if_day_int_top_info(logger){
		var uiH = new helper();
		
		Test.assertEqualMessage(0,uiH.bonusDayInTop(1),"Do not show next day if month and year at top");
		Test.assertEqualMessage(1,uiH.bonusDayInTop(2),"Show next day if month and day are at top");
		Test.assertEqualMessage(1,uiH.bonusDayInTop(3),"Show next day if month day and year are top");
		Test.assertEqualMessage(1,uiH.bonusDayInTop(4),"Show next day if short full date is at top");
		Test.assertEqualMessage(1,uiH.bonusDayInTop(5),"Show next day if short full date is at top");
		Test.assertEqualMessage(0,uiH.bonusDayInTop(6),"Do not show next day if ssteps are at top");
		return true;	
	}
	
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
	
    	uiH.drawTopRight(1,dc,88,-5,14,0,3);
    	uiH.drawTopRight(2,dc,88,-5,14,0,3);
    	uiH.drawTopRight(3,dc,88,-5,14,0,3);
    	uiH.drawTopRight(4,dc,88,-5,14,0,3);
    	
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
		var font = uiH.getSmallFont();
    	uiH.drawBottomLineByOption(dc,88,-5,1,font);
    	uiH.drawBottomLineByOption(dc,88,-5,2,font);
    	uiH.drawBottomLineByOption(dc,88,-5,3,font);
    	uiH.drawBottomLineByOption(dc,88,-5,4,font);    		
    	uiH.drawBottomLineByOption(dc,88,-5,5,font);
    	uiH.drawBottomLineByOption(dc,88,-5,6,font);
    	return true;
	}
	
	(:test)
	function success_get_basic_info_short(logger){
		var uiH = new helper();
		uiH.shortFormat=true;
		uiH.getSteps();
		uiH.getCalories();
		uiH.getMsgs();
		uiH.getBattery();
		uiH.getHR();
		return true;	
	}
	
	(:test)
	function success_get_basic_info_not_short(logger){
		var uiH = new helper();
		uiH.shortFormat=false;
		uiH.getSteps();
		uiH.getCalories();
		uiH.getMsgs();
		uiH.getBattery();
		uiH.getHR();
		return true;	
	}
	

}	