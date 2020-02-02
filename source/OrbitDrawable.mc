using Toybox.Application;
using Toybox.System;
using Toybox.WatchUi;

class OrbitDrawable extends WatchUi.Drawable {
    protected function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();      
        screenWidth = settings.screenWidth;
        screenHeight = settings.screenHeight;
        screenCenterX = screenWidth / 2;
        screenCenterY = screenHeight / 2;
    }
    
    protected function getColor(colorPropertyName) {
        var color = Application.Properties.getValue(colorPropertyName);
        if (color == -1) {
            var theme = Application.Properties.getValue(Properties.theme);
            return themeColors[colorPropertyName][theme];
        }
        
        return color;
    }
    
    protected static var screenWidth;
    protected static var screenHeight;
    protected static var screenCenterX;
    protected static var screenCenterY;

    protected const themeColors = {
        Properties.backgroundColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_DK_GRAY,
            /* 2 Venus */ Graphics.COLOR_BLACK,
            /* 3 Earth */ Graphics.COLOR_BLACK,
            /* 4 Mars */ Graphics.COLOR_BLACK,
            /* 5 Jupiter */ Graphics.COLOR_BLACK,
            /* 6 Saturn */ Graphics.COLOR_BLACK,
            /* 7 Uranus */ Graphics.COLOR_WHITE,
            /* 8 Neptune */ Graphics.COLOR_BLUE,
            /* 9 Pluto */ Graphics.COLOR_BLACK
        ],
        Properties.hoursColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_LT_GRAY,
            /* 2 Venus */ Graphics.COLOR_ORANGE,
            /* 3 Earth */ Graphics.COLOR_BLUE,
            /* 4 Mars */ Graphics.COLOR_ORANGE,
            /* 5 Jupiter */ Graphics.COLOR_YELLOW,
            /* 6 Saturn */ Graphics.COLOR_ORANGE,
            /* 7 Uranus */ Graphics.COLOR_DK_BLUE,
            /* 8 Neptune */ Graphics.COLOR_WHITE,
            /* 9 Pluto */ 0x8B4513, /* brown */
        ],
        Properties.minutesColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_BLACK,
            /* 2 Venus */ Graphics.COLOR_YELLOW,
            /* 3 Earth */ Graphics.COLOR_GREEN,
            /* 4 Mars */ Graphics.COLOR_RED,
            /* 5 Jupiter */ Graphics.COLOR_RED,
            /* 6 Saturn */ Graphics.COLOR_YELLOW,
            /* 7 Uranus */ Graphics.COLOR_BLUE,
            /* 8 Neptune */ Graphics.COLOR_DK_BLUE,
            /* 9 Pluto */ 0xFA8072, /* salmon */
        ],
        Properties.secondsColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_BLACK,
            /* 2 Venus */ Graphics.COLOR_WHITE,
            /* 3 Earth */ Graphics.COLOR_WHITE,
            /* 4 Mars */ Graphics.COLOR_RED,
            /* 5 Jupiter */ Graphics.COLOR_LT_GRAY,
            /* 6 Saturn */ Graphics.COLOR_DK_GRAY,
            /* 7 Uranus */ Graphics.COLOR_GREEN,
            /* 8 Neptune */ Graphics.COLOR_DK_BLUE,
            /* 9 Pluto */ Graphics.COLOR_DK_GRAY
        ],
        Properties.outerGoalColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_LT_GRAY,
            /* 2 Venus */ Graphics.COLOR_YELLOW,
            /* 3 Earth */ Graphics.COLOR_BLUE,
            /* 4 Mars */ Graphics.COLOR_ORANGE,
            /* 5 Jupiter */ 0x8B4513, /* brown */
            /* 6 Saturn */ Graphics.COLOR_PINK,
            /* 7 Uranus */ Graphics.COLOR_DK_GREEN,
            /* 8 Neptune */ Graphics.COLOR_WHITE,
            /* 9 Pluto */ Graphics.COLOR_LT_GRAY
        ],
        Properties.innerGoalColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_BLUE,
            /* 2 Venus */ 0x8B4513, /* brown */
            /* 3 Earth */ Graphics.COLOR_DK_GREEN,
            /* 4 Mars */ Graphics.COLOR_YELLOW,
            /* 5 Jupiter */ Graphics.COLOR_ORANGE,
            /* 6 Saturn */ 0x8B4513, /* brown */
            /* 7 Uranus */ Graphics.COLOR_DK_GRAY,
            /* 8 Neptune */ Graphics.COLOR_BLACK,
            /* 9 Pluto */ Graphics.COLOR_WHITE
        ],
        Properties.dateColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_WHITE,
            /* 2 Venus */ Graphics.COLOR_WHITE,
            /* 3 Earth */ Graphics.COLOR_WHITE,
            /* 4 Mars */ Graphics.COLOR_WHITE,
            /* 5 Jupiter */ Graphics.COLOR_WHITE,
            /* 6 Saturn */ Graphics.COLOR_WHITE,
            /* 7 Uranus */ Graphics.COLOR_BLACK,
            /* 8 Neptune */ Graphics.COLOR_WHITE,
            /* 9 Pluto */ Graphics.COLOR_WHITE
        ],
        Properties.batteryColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Mercury */ Graphics.COLOR_WHITE,
            /* 2 Venus */ Graphics.COLOR_WHITE,
            /* 3 Earth */ Graphics.COLOR_WHITE,
            /* 4 Mars */ Graphics.COLOR_WHITE,
            /* 5 Jupiter */ Graphics.COLOR_WHITE,
            /* 6 Saturn */ Graphics.COLOR_WHITE,
            /* 7 Uranus */ Graphics.COLOR_BLACK,
            /* 8 Neptune */ Graphics.COLOR_WHITE,
            /* 9 Pluto */ Graphics.COLOR_WHITE
        ]
    };    
}
