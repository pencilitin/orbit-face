using Toybox.Application;

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
        if (WatchUi has :WatchFaceDelegate) {
            return [new OrbitView(), new OrbitDelegate()];
        }
        else {
            return [new OrbitView()];
        }
    }
}