using Toybox.System;

module DeviceType {
    const VENU = 0;
    const VENU_454 = 1;
    const VENU_416 = 2;
    const VIVOACTIVE_HR = 3;
    const FR920XT = 4;
    const FR230_FR235 = 5;
    const FR45 = 6;
    const FENIX3 = 7;
    const FR245_FENIX5X = 8;
    const FENIX6 = 9;
    const FENIX6XPRO = 10;
    const VENUSQ = 11;
    const DEVICE_176 = 12;
    const DEVICE_163 = 13;
    const DEVICE_166 = 14;
    const UNKNOWN = 15;
}

class DeviceService {
    
    static function detectDeviceType() {
        var width = System.getDeviceSettings().screenWidth;
        var height = System.getDeviceSettings().screenHeight;
        var shape = System.getDeviceSettings().screenShape;
        
        var deviceKey = width + "x" + height + "x" + shape;
        
        switch(deviceKey) {
            case "390x390x1":
            case "360x360x1":
                return DeviceType.VENU;
            case "454x454x1":
                return DeviceType.VENU_454;
            case "416x416x1":
                return DeviceType.VENU_416;
            case "148x205x3":
                return DeviceType.VIVOACTIVE_HR;
            case "205x148x3":
                return DeviceType.FR920XT;
            case "215x180x2":
                return DeviceType.FR230_FR235;
            case "208x208x1":
                return DeviceType.FR45;
            case "218x218x1":
                return DeviceType.FENIX3;
            case "240x240x1":
                return DeviceType.FR245_FENIX5X;
            case "260x260x1":
                return DeviceType.FENIX6;
            case "280x280x1":
                return DeviceType.FENIX6XPRO;
            case "240x240x3":
                return DeviceType.VENUSQ;
            case "176x176x4":
                return DeviceType.DEVICE_176;
            case "163x156x4":
                return DeviceType.DEVICE_163;
            case "166x166x4":
                return DeviceType.DEVICE_166;
            default:
                return DeviceType.UNKNOWN;
        }
    }
    
    static function isOledDisplay(deviceType) {
        return (deviceType == DeviceType.VENU || 
                deviceType == DeviceType.VENU_454 || 
                deviceType == DeviceType.VENU_416);
    }
    
    static function getDeviceInfo(debug) {
        var deviceType = detectDeviceType();
        var isOled = isOledDisplay(deviceType);
        
        if (debug) {
            var width = System.getDeviceSettings().screenWidth;
            var height = System.getDeviceSettings().screenHeight;
            var shape = System.getDeviceSettings().screenShape;
            var deviceKey = width + "x" + height + "x" + shape;
            
            System.println("Detected device type: " + deviceType + " (" + deviceKey + ")");
            System.println("OLED display: " + isOled);
        }
        
        return {
            :deviceType => deviceType,
            :isOled => isOled
        };
    }
}