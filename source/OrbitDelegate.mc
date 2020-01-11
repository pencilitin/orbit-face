using Toybox.WatchUi;

class OrbitDelegate extends WatchUi.WatchFaceDelegate {
    function initialize() {
        WatchFaceDelegate.initialize();
    }

    function onPowerBudgetExceeded(powerInfo) {
        System.println("Average execution time: " + powerInfo.executionTimeAverage);
        System.println("Allowed execution time: " + powerInfo.executionTimeLimit);
    }
}
