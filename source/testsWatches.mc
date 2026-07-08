using Toybox.Test;

class WatchfacesTests {
	
	(:test)
	function success_run_all_watchfaces_on_each_device(logger){
		var app = new phoneBatteryIQView();
		var dc = new mockDC(logger);
		
		app.onUpdate(dc);
		
		app.draw_148x205x3(dc);
		app.draw_205x148x3(dc);
		app.draw_215x180x2(dc);
		app.draw_218x218x1(dc);
		app.draw_208x208x1(dc);
		app.draw_240x240x1(dc);
		app.draw_240x240x3(dc);
		app.draw_260x260x1(dc);
		app.draw_280x280x1(dc);
		app.draw_390x390x1(dc);
		app.draw_416x416x1(dc);
		app.draw_448x486x3(dc);
		app.draw_454x454x1(dc);
		app.draw_176x176x4(dc);
		app.draw_163x156x4(dc);
		app.draw_166x166x4(dc);

		return true;
	}

}
