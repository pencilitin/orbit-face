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
        goalMeterRadius = params[:radius];
        textY = params[:textY];
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

        // Draw goal meter tick marks.
        for (var i = 1; i < 12; i++) {
            if (stepsPercent >= i.toFloat() / 12) {
                var radius = i % 3 == 0 ? 5 : 3;
                var angleRadians = Math.toRadians(630 - (i * 30));
                var dotX = screenCenterX + (Math.cos(angleRadians) * goalMeterRadius).toNumber();
                var dotY = screenCenterY - (Math.sin(angleRadians) * goalMeterRadius).toNumber();
                dc.setColor(stepsPercent < 1 ? Graphics.COLOR_BLACK : Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(dotX, dotY, radius);
                if (stepsPercent < 1) {
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                    dc.drawCircle(dotX, dotY, radius);
                }
            }
        }        
        
        // Draw step count.
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(
            screenCenterX,
            textY,
            Graphics.FONT_SYSTEM_SMALL,
            info.steps,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    private var screenCenterX;
    private var screenCenterY;
    private var goalMeterRadius;
    private var textY;
}
