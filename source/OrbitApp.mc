using Toybox.Application;
using Toybox.WatchUi;

class OrbitApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        view = new OrbitView();
        updateThemeColors();
        if (WatchUi has :WatchFaceDelegate) {
            return [view, new OrbitDelegate()];
        }
        else {
            return [view];
        }
    }
    
    function onSettingsChanged() {
        updateThemeColors();
        WatchUi.requestUpdate();
    }
    
    private function updateThemeColors() {
        var theme = Application.Properties.getValue(Properties.theme);
        Application.Properties.setValue(Properties.backgroundColor, backgroundColors[theme]);
        Application.Properties.setValue(Properties.hoursColor, hoursColors[theme]);
        Application.Properties.setValue(Properties.minutesColor, minutesColors[theme]);
        Application.Properties.setValue(Properties.secondsColor, secondsColors[theme]);
        Application.Properties.setValue(Properties.outerGoalColor, outerGoalColors[theme]);
        Application.Properties.setValue(Properties.innerGoalColor, innerGoalColors[theme]);
        Application.Properties.setValue(Properties.dateColor, dateColors[theme]);
        Application.Properties.setValue(Properties.batteryColor, batteryColors[theme]);
    }

    private var view;    
    private const backgroundColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_DK_GRAY,
        /* 2 Venus */ Graphics.COLOR_BLACK,
        /* 3 Earth */ Graphics.COLOR_BLACK,
        /* 4 Mars */ Graphics.COLOR_DK_RED,
        /* 5 Jupiter */ Graphics.COLOR_BLACK,
        /* 6 Saturn */ Graphics.COLOR_BLACK,
        /* 7 Uranus */ Graphics.COLOR_WHITE,
        /* 8 Neptune */ Graphics.COLOR_BLUE,
        /* 9 Pluto */ Graphics.COLOR_BLACK
    ];
    private const hoursColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_BLUE,
        /* 2 Venus */ Graphics.COLOR_ORANGE,
        /* 3 Earth */ Graphics.COLOR_BLUE,
        /* 4 Mars */ Graphics.COLOR_RED,
        /* 5 Jupiter */ Graphics.COLOR_RED,
        /* 6 Saturn */ Graphics.COLOR_LT_GRAY,
        /* 7 Uranus */ Graphics.COLOR_DK_BLUE,
        /* 8 Neptune */ Graphics.COLOR_WHITE,
        /* 9 Pluto */ Graphics.COLOR_RED
    ];
    private const minutesColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_BLUE,
        /* 2 Venus */ Graphics.COLOR_YELLOW,
        /* 3 Earth */ Graphics.COLOR_GREEN,
        /* 4 Mars */ Graphics.COLOR_RED,
        /* 5 Jupiter */ Graphics.COLOR_RED,
        /* 6 Saturn */ Graphics.COLOR_WHITE,
        /* 7 Uranus */ Graphics.COLOR_BLUE,
        /* 8 Neptune */ Graphics.COLOR_DK_BLUE,
        /* 9 Pluto */ Graphics.COLOR_BLUE
    ];
    private const secondsColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_BLUE,
        /* 2 Venus */ Graphics.COLOR_RED,
        /* 3 Earth */ Graphics.COLOR_WHITE,
        /* 4 Mars */ Graphics.COLOR_RED,
        /* 5 Jupiter */ Graphics.COLOR_WHITE,
        /* 6 Saturn */ Graphics.COLOR_WHITE,
        /* 7 Uranus */ Graphics.COLOR_DK_BLUE,
        /* 8 Neptune */ Graphics.COLOR_BLACK,
        /* 9 Pluto */ Graphics.COLOR_PINK
    ];
    private const outerGoalColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_LT_GRAY,
        /* 2 Venus */ Graphics.COLOR_LT_GRAY,
        /* 3 Earth */ Graphics.COLOR_BLUE,
        /* 4 Mars */ Graphics.COLOR_ORANGE,
        /* 5 Jupiter */ Graphics.COLOR_YELLOW,
        /* 6 Saturn */ Graphics.COLOR_PINK,
        /* 7 Uranus */ Graphics.COLOR_BLACK,
        /* 8 Neptune */ Graphics.COLOR_WHITE,
        /* 9 Pluto */ Graphics.COLOR_ORANGE
    ];
    private const innerGoalColors = [
        /* 0 None */ Graphics.COLOR_BLACK,
        /* 1 Mercury */ Graphics.COLOR_LT_GRAY,
        /* 2 Venus */ Graphics.COLOR_LT_GRAY,
        /* 3 Earth */ Graphics.COLOR_DK_GREEN,
        /* 4 Mars */ Graphics.COLOR_YELLOW,
        /* 5 Jupiter */ Graphics.COLOR_ORANGE,
        /* 6 Saturn */ Graphics.COLOR_YELLOW,
        /* 7 Uranus */ Graphics.COLOR_DK_GRAY,
        /* 8 Neptune */ Graphics.COLOR_BLACK,
        /* 9 Pluto */ Graphics.COLOR_YELLOW
    ];
    private const dateColors = [
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
    ];
    private const batteryColors = [
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
    ];
}