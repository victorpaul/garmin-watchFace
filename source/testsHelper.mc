class helperTest {

	(:test)
	function success_first_test(logger){
		var x = 2 + 2; 
		logger.debug("x = " + x);
    	return (x == 4);
	}

}	