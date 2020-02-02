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
        var view = new OrbitView();
        if (WatchUi has :WatchFaceDelegate) {
            return [view, new OrbitDelegate()];
        }
        else {
            return [view];
        }
    }
    
    function onSettingsChanged() {
        WatchUi.requestUpdate();
    }
}
