using Toybox.Test;

class WatchfacesTests {
	
	// Exercises only the draw_ function onUpdate() actually dispatches to
	// for the device this test binary was compiled for -- matches what a
	// real watch runs (one layout per frame), instead of every layout in
	// one call, which blew past the object budget on older/low-memory
	// devices without ever reflecting what production does.
	(:test)
	function success_run_watchface_for_current_device(logger){
		var app = new phoneBatteryIQView();
		var dc = new mockDC(logger);

		app.onUpdate(dc);

		return true;
	}

}
