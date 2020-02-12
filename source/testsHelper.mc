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
		Test.assertEqualMessage(1,uiH.bonusDayInTop(12),"Show next day if week day at top");
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
	function success_get_y_correction_according_to_device(logger){
		var uiH = new helper();
		Test.assertEqualMessage(true,uiH.getYfixForOldFont_(true)>0,"For old font, there is always correction by Y");
		Test.assertEqualMessage(0,uiH.getYfixForOldFont_(false),"For current font should not be any correction by Y");
	
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
	function success_get_fonts_and_do_not_crash(logger){
		var uiH = new helper();
		logger.debug("asdasdasdasd");
		uiH.fontSmall();
		uiH.fontSmall_(0);
		uiH.fontSmall_(1);
		uiH.fontSmall_(2);
		uiH.fontSmall_(3);
		uiH.fontSmall_(4);
		uiH.fontSmall_(5);
		
    	uiH.fontHuge245();
    	uiH.fontHuge245_(true);
    	uiH.fontHuge245_(false);
    	
    	uiH.fontHuge45();
    	uiH.fontHuge45_(true);
    	uiH.fontHuge45_(false);
    	
    	uiH.fontMedium();
    	uiH.fontMedium_(0);
    	uiH.fontMedium_(1);
    	uiH.fontMedium_(2);
    	uiH.fontMedium_(3);
    	uiH.fontMedium_(4);
    	uiH.fontMedium_(5);
    	return true;
	}
	
	(:test)
	function success_draw_bottom_line(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
		var font = uiH.fontSmall();
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
	
	(:test)
	function success_get_days_of_week(logger){
		var uiH = new helper();
		uiH.getWeekdayName(1);
		
		Test.assertEqual("Sun",uiH.getWeekdayName_(1,1));
		Test.assertEqual("Mon",uiH.getWeekdayName_(2,1));
		Test.assertEqual("Tue",uiH.getWeekdayName_(3,1));
		Test.assertEqual("Wed",uiH.getWeekdayName_(4,1));
		Test.assertEqual("Thu",uiH.getWeekdayName_(5,1));
		Test.assertEqual("Fri",uiH.getWeekdayName_(6,1));
		Test.assertEqual("Sat",uiH.getWeekdayName_(7,1));
		
		Test.assertNotEqual("sun",uiH.getWeekdayName_(1,1));
		Test.assertNotEqual("mon",uiH.getWeekdayName_(2,1));
		
		Test.assertEqual("sun",uiH.getWeekdayName_(1,2));
		Test.assertEqual("mon",uiH.getWeekdayName_(2,2));
		Test.assertEqual("tue",uiH.getWeekdayName_(3,2));
		Test.assertEqual("wed",uiH.getWeekdayName_(4,2));
		Test.assertEqual("thu",uiH.getWeekdayName_(5,2));
		Test.assertEqual("fri",uiH.getWeekdayName_(6,2));
		Test.assertEqual("sat",uiH.getWeekdayName_(7,2));
		
		return true;
	}
	

}	