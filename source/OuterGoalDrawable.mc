using Helpers;
using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.System;
using Toybox.WatchUi;

class OuterGoalDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();      
        screenCenterX = settings.screenWidth / 2;
        screenCenterY = settings.screenHeight / 2;
        goalMeterRadius = Helpers.minimum(settings.screenWidth, settings.screenHeight) / 32 * 14;
    }
    
    function draw(dc) {
        var info = ActivityMonitor.getInfo();
        var stepsPercent = info.steps.toFloat() / info.stepGoal.toFloat();
        if (stepsPercent > 1) {
            stepsPercent = 1;
        }
        
        // Draw step goal meter.
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        if (stepsPercent != 0) {
            dc.drawArc(
                screenCenterX,
                screenCenterY,
                goalMeterRadius,
                Graphics.ARC_CLOCKWISE,
                630,
                630 - (360 * stepsPercent));
        }
        if (stepsPercent >= 0.25) {
            dc.fillCircle(
                screenCenterX - goalMeterRadius,
                screenCenterY,
                5);
        }
        if (stepsPercent >= 0.5) {
            dc.fillCircle(
                screenCenterX,
                screenCenterY - goalMeterRadius,
                5);
        }
        if (stepsPercent >= 0.75) {
            dc.fillCircle(
                screenCenterX + goalMeterRadius,
                screenCenterY,
                5);
        }
        
        // Draw step count.
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(
            screenCenterX,
            screenCenterY + goalMeterRadius - 5,
            Graphics.FONT_SYSTEM_SMALL,
            info.steps,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    private var screenCenterX;
    private var screenCenterY;
    private var goalMeterRadius;
}
