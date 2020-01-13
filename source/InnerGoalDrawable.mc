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
        goalMeterRadius = params[:radius];
        textY = params[:textY];
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
        
        // Draw goal meter tick marks.
        for (var i = 1; i < 6; i++) {
            if (floorsPercent >= i.toFloat() / 6) {
                var angleRadians = Math.toRadians(630 - (i * 60));
                var dotX = screenCenterX + (Math.cos(angleRadians) * goalMeterRadius).toNumber();
                var dotY = screenCenterY - (Math.sin(angleRadians) * goalMeterRadius).toNumber();
                dc.setColor(floorsPercent < 1 ? Graphics.COLOR_BLACK : Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(dotX, dotY, 4);
                if (floorsPercent < 1) {
                    dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
                    dc.drawCircle(dotX, dotY, 4);
                }
            }
        }

        // Draw floor count.
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
        dc.drawText(
            screenCenterX,
            textY,
            Graphics.FONT_SYSTEM_SMALL,
            info.floorsClimbed,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private var screenCenterX;
    private var screenCenterY;
    private var goalMeterRadius;
    private var textY;
}
