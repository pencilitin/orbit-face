using Toybox.Application;
using Toybox.WatchUi;

class OrbitApp extends Application.AppBase {

    public const GOAL_TYPE_CALORIES = 9;

    function initialize() {
        AppBase.initialize();
        loadProperties();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        var view = new OrbitView();
        if (WatchUi has :WatchFaceDelegate) {
            return [view, new OrbitDelegate()];
        }
        else {
            return [view];
        }
    }
    
    function onSettingsChanged() {
        loadProperties();
        WatchUi.requestUpdate();
    }

    var properties = {};

    private function loadProperties() {
        properties.put(Properties.showSeconds, Application.Properties.getValue(Properties.showSeconds));
        properties.put(Properties.theme, Application.Properties.getValue(Properties.theme));
        properties.put(Properties.backgroundColor, Application.Properties.getValue(Properties.backgroundColor));
        properties.put(Properties.hoursColor, Application.Properties.getValue(Properties.hoursColor));
        properties.put(Properties.minutesColor, Application.Properties.getValue(Properties.minutesColor));
        properties.put(Properties.secondsColor, Application.Properties.getValue(Properties.secondsColor));
        properties.put(Properties.outerGoalColor, Application.Properties.getValue(Properties.outerGoalColor));
        properties.put(Properties.innerGoalColor, Application.Properties.getValue(Properties.innerGoalColor));
        properties.put(Properties.dateColor, Application.Properties.getValue(Properties.dateColor));
        properties.put(Properties.batteryColor, Application.Properties.getValue(Properties.batteryColor));
        properties.put(Properties.outerGoalType, Application.Properties.getValue(Properties.outerGoalType));
        properties.put(Properties.innerGoalType, Application.Properties.getValue(Properties.innerGoalType));
        properties.put(Properties.caloriesGoal, Application.Properties.getValue(Properties.caloriesGoal));
    }
}

function getApp() as OrbitApp {
    return Application.getApp() as OrbitApp;
}
