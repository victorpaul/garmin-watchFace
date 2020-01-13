using Toybox.Test;

class WatchfacesTests {
	
	(:test)
	function success_run_all_watchfaces_on_each_device(logger){
		var app = new phoneBatteryIQView();
		var dc = new mockDC(logger);
		
		app.onUpdate(dc);
		
		app.draw_vivoactiveHR(dc);
		app.draw_fr920xt(dc);
		app.draw_fr230_fr235(dc);
		app.draw_fenix3(dc);
		app.draw_fr45(dc);
		app.draw_fr245_fenix5x(dc);
		app.draw_fenix6(dc);
		app.draw_fenix6xpro(dc);
		
		return true;
	}

}
