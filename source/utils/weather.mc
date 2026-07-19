using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Weather;

class weather {

    var hasWeather;

    function initialize() {
        hasWeather = (Toybox has :Weather) && (Weather has :getCurrentConditions);
    }

    // Text + icon combo, same convention as steps/floors/messages/hr:
    // number first, weather icon after.
    function drawWeather(dc, x, y, font, align) {
        var iconIds = [Rez.Drawables.weather_cloudy_dark, Rez.Drawables.weather_cloudy_light]; //getWeatherIconIds();
        IconTheme.drawIconWithText(dc, x, y, font, getTemperature(), align, iconIds[0], iconIds[1]);
    }

    function getTemperature() {
        if (!hasWeather) {
            return "--°";
        }
        try {
            var conditions = Weather.getCurrentConditions();
            if (conditions != null && conditions.temperature != null) {
                var temp = conditions.temperature.toNumber();

                if (System.getDeviceSettings().temperatureUnits == System.UNIT_METRIC) {
                    return temp.format("%d") + "°C";
                } else {
                    return temp.format("%d") + "°F";
                }
            }
        } catch(ex) {
        }

        return "--°";
    }

    function getWeatherIconIds() {
        if (!hasWeather) {
            return null;
        }
        try {
            var conditions = Weather.getCurrentConditions();
            if (conditions != null && conditions.condition != null) {
                return mapConditionToIconIds(conditions.condition);
            }
        } catch(ex) {
        }

        return null;
    }

    function mapConditionToIconIds(condition) {
        switch(condition) {
            case Weather.CONDITION_CLEAR:
                return [Rez.Drawables.weather_clear_dark, Rez.Drawables.weather_clear_light];
            case Weather.CONDITION_PARTLY_CLOUDY:
            case Weather.CONDITION_PARTLY_CLEAR:
                return [Rez.Drawables.weather_partly_cloudy_dark, Rez.Drawables.weather_partly_cloudy_light];
            case Weather.CONDITION_CLOUDY:
            case Weather.CONDITION_MOSTLY_CLOUDY:
                return [Rez.Drawables.weather_cloudy_dark, Rez.Drawables.weather_cloudy_light];
            case Weather.CONDITION_RAIN:
            case Weather.CONDITION_LIGHT_RAIN:
            case Weather.CONDITION_HEAVY_RAIN:
            case Weather.CONDITION_SHOWERS:
                return [Rez.Drawables.weather_rainy_dark, Rez.Drawables.weather_rainy_light];
            case Weather.CONDITION_SNOW:
            case Weather.CONDITION_LIGHT_SNOW:
            case Weather.CONDITION_HEAVY_SNOW:
            case Weather.CONDITION_CHANCE_OF_SNOW:
                return [Rez.Drawables.weather_snowy_dark, Rez.Drawables.weather_snowy_light];
            case Weather.CONDITION_THUNDERSTORMS:
            case Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
                return [Rez.Drawables.weather_thunderstorm_dark, Rez.Drawables.weather_thunderstorm_light];
            case Weather.CONDITION_FOG:
            case Weather.CONDITION_HAZE:
            case Weather.CONDITION_MIST:
                return [Rez.Drawables.weather_foggy_dark, Rez.Drawables.weather_foggy_light];
            case Weather.CONDITION_WINDY:
                return [Rez.Drawables.weather_air_dark, Rez.Drawables.weather_air_light];
            default:
                return [Rez.Drawables.weather_cloudy_dark, Rez.Drawables.weather_cloudy_light];
        }
    }
}
