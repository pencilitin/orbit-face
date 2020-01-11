using Helpers;
using Toybox.ActivityMonitor;
using Toybox.System;
using Toybox.WatchUi;

class InnerGoalDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();      
        screenCenterX = settings.screenWidth / 2;
        screenCenterY = settings.screenHeight / 2;
        goalMeterRadius = Helpers.minimum(settings.screenWidth, settings.screenHeight) / 32 * 10;
    }
    
    function draw(dc) {
        var info = ActivityMonitor.getInfo();
        var floorsPercent = info.floorsClimbed.toFloat() / info.floorsClimbedGoal.toFloat();
        if (floorsPercent > 1) {
            floorsPercent = 1;
        }
        
        // Draw floor goal meter.
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        if (floorsPercent != 0) {
            dc.drawArc(
                screenCenterX,
                screenCenterY,
                goalMeterRadius,
                Graphics.ARC_CLOCKWISE,
                630,
                630 - (360 * floorsPercent));
        }
        if (floorsPercent >= 0.25) {
            dc.fillCircle(
                screenCenterX - goalMeterRadius,
                screenCenterY,
                5);
        }
        if (floorsPercent >= 0.5) {
            dc.fillCircle(
                screenCenterX,
                screenCenterY - goalMeterRadius,
                5);
        }
        if (floorsPercent >= 0.75) {
            dc.fillCircle(
                screenCenterX + goalMeterRadius,
                screenCenterY,
                5);
        }

        // Draw floor count.
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
        dc.drawText(
            screenCenterX,
            screenCenterY + goalMeterRadius - 2,
            Graphics.FONT_SYSTEM_SMALL,
            info.floorsClimbed,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private var screenCenterX;
    private var screenCenterY;
    private var goalMeterRadius;
}
