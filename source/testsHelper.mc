using Toybox.Test;

class HelperTests {

	(:test)
	function success_draw_empty_TopRight_block_without_hr(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawTopRight(dc,88,-5,14,3);
    	
    	logger.debug(dc.calls);
    	
    	Test.assertEqual("drawText(88,-5,text,2)",dc.calls[0][0]);
    	Test.assertEqual("drawText(88,9,text,2)",dc.calls[1][0]);
    	Test.assertEqual("drawText(88,23,text,2)",dc.calls[2][0]);
    	
    	Test.assertEqual(3,dc.calls.size());	
    	return true;
	}
	
	(:test)
	function success_drawTopRight_block_with_hr(logger){
		var dc = new mockDC(logger);
		var uiH = new helper();
	
    	uiH.drawTopRight(dc,88,-5,14,3);
    	
    	logger.debug(dc.calls);
    	
    	Test.assertEqual("drawText(88,-5,text,2)",dc.calls[0][0]);
    	Test.assertEqual("drawText(88,9,text,2)",dc.calls[1][0]);
    	Test.assertEqual("drawText(88,23,text,2)",dc.calls[2][0]);
    	
    	Test.assertEqual(3,dc.calls.size());	
    	return true;
	}

}	