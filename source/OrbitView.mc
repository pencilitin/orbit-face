using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class OrbitView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        timeDrawable = View.findDrawableById("Time");
        outerGoalDrawable = View.findDrawableById("OuterGoal");
        innerGoalDrawable = View.findDrawableById("InnerGoal");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        dc.clearClip();
        updateGoals();
        View.onUpdate(dc);
    }

    function onPartialUpdate(dc) {
        timeDrawable.drawSeconds(dc, true);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

    private function updateGoals() {
        var outerGoalValues = getGoalValues(Application.Properties.getValue(Properties.outerGoalType));
        outerGoalDrawable.setGoalValues(outerGoalValues[:current], outerGoalValues[:goal]);
        var innerGoalValues = getGoalValues(Application.Properties.getValue(Properties.innerGoalType));
        innerGoalDrawable.setGoalValues(innerGoalValues[:current], innerGoalValues[:goal]);
    }
    
    private function getGoalValues(goalType) {
        var values = {
            :current => 0,
            :goal => 1
        };
        var info = ActivityMonitor.getInfo();
        switch (goalType) {
            case Application.GOAL_TYPE_STEPS:
                values[:current] = info.steps;
                values[:goal] = info.stepGoal;
                break;
            case Application.GOAL_TYPE_FLOORS_CLIMBED:
                values[:current] = info.floorsClimbed;
                values[:goal] = info.floorsClimbedGoal;
                break;
            case Application.GOAL_TYPE_ACTIVE_MINUTES:
                values[:current] = info.activeMinutesWeek.total;
                values[:goal] = info.activeMinutesWeekGoal;
                break;
        }

        if (values[:goal] < 1) {
            values[:goal] = 1;
        }

        return values;
    }
        
    private var timeDrawable;
    private var outerGoalDrawable;
    private var innerGoalDrawable;
}
