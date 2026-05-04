using Toybox.Application;

// AodManager
//
// Tracks the watch sleep/awake state for AOD emulation.
// The Fenix 7X is a MIP watch with no native AOD;
// we emulate it via onEnterSleep / onExitSleep.

class AodManager {

    hidden var _sleeping;

    function initialize() {
        _sleeping = false;
    }

    function onSleep() {
        _sleeping = true;
    }

    function onWake() {
        _sleeping = false;
    }

    // Returns true when only the time should be drawn.
    function isSleeping() {
        if (!_isEnabled()) { return false; }
        return _sleeping;
    }

    hidden function _isEnabled() {
        var v = Application.getApp().getProperty("AodEnabled");
        if (v == null) { return true; }
        return v;
    }
}
