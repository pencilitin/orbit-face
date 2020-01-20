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
        if (Application.Properties.getValue(Properties.innerGoalType) == -1) {
            return;
        }
        
        var goalPercent = current.toFloat() / goal.toFloat();
        if (goalPercent > 1) {
            goalPercent = 1;
        }
        
        var innerGoalColor = Application.Properties.getValue(Properties.innerGoalColor);
        var backgroundColor = Application.Properties.getValue(Properties.backgroundColor);

        // Draw floor goal meter.
        dc.setColor(innerGoalColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        if (goalPercent != 0) {
            dc.drawArc(
                screenCenterX,
                screenCenterY,
                goalMeterRadius,
                Graphics.ARC_CLOCKWISE,
                630,
                630 - (360 * goalPercent));
        }
        
        // Draw goal meter tick marks.
        var tickFillColor = goalPercent < 1 ? backgroundColor : innerGoalColor;
        for (var i = 1; i < 6; i++) {
            if (goalPercent >= i.toFloat() / 6) {
                var angleRadians = Math.toRadians(630 - (i * 60));
                var dotX = screenCenterX + (Math.cos(angleRadians) * goalMeterRadius).toNumber();
                var dotY = screenCenterY - (Math.sin(angleRadians) * goalMeterRadius).toNumber();
                dc.setColor(tickFillColor, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(dotX, dotY, 4);
                if (goalPercent < 1) {
                    dc.setColor(innerGoalColor, backgroundColor);
                    dc.drawCircle(dotX, dotY, 4);
                }
            }
        }

        // Draw floor count.
        dc.setColor(innerGoalColor, backgroundColor);
        dc.drawText(
            screenCenterX,
            textY,
            Graphics.FONT_SYSTEM_SMALL,
            current,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function setGoalValues(current, goal) {
        self.current = current;
        self.goal = goal;
    }
    
    private var screenCenterX;
    private var screenCenterY;
    private var goalMeterRadius;
    private var textY;
    private var current;
    private var goal;
}
