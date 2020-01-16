using Toybox.Lang;

class mockDC{
	var logger;
	var calls = new[0];
	
	function initialize(logger_) {
    	logger = logger_;
	}
	
	function drawText(hourX,hourY,font,text,justify){
		var str = Lang.format("drawText($1$,$2$,$3$,$4$)",[hourX,hourY,"text",justify]);
//		logger.debug(Lang.format("$1$: $2$",[calls.size(),str]));
		calls.add([str,text]);
	}
	
	function setColor(color1, color2){
		var str = Lang.format("setColor($1$,$2$)",[color1, color2]);
//		logger.debug(Lang.format("$1$: $2$",[calls.size(),str]));
		calls.add([str]);
	}
	
	function clear(){
		var str = "clear()";
//		logger.debug(Lang.format("$1$: $2$",[calls.size(),str]));
		calls.add([str]);
	}
	
}