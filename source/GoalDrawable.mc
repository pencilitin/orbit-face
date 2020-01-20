using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.System;
using Toybox.WatchUi;

class GoalDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();      
        screenCenterX = settings.screenWidth / 2;
        screenCenterY = settings.screenHeight / 2;
        goalTypeName = params[:goalTypeName];
        goalColorName = params[:goalColorName];
        goalMeterRadius = params[:radius];
        tickCount = params[:tickCount];
        largeTickRadius = params[:largeTickRadius];
        smallTickRadius = params[:smallTickRadius];
        largeTickFrequency = params[:largeTickFrequency];
        textY = params[:textY];
    }
    
    function draw(dc) {
        if (Application.Properties.getValue(goalTypeName) == -1) {
            return;
        }
        
        var goalPercent = current.toFloat() / goal.toFloat();
        if (goalPercent > 1) {
            goalPercent = 1;
        }
        
        var goalColor = Application.Properties.getValue(goalColorName);
        var backgroundColor = Application.Properties.getValue(Properties.backgroundColor);

        // Draw goal meter.
        dc.setColor(goalColor, Graphics.COLOR_TRANSPARENT);
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
        var tickFillColor = goalPercent < 1 ? backgroundColor : goalColor;
        for (var i = 1; i < tickCount; i++) {
            if (goalPercent >= i.toFloat() / tickCount) {
                var radius = i % largeTickFrequency == 0 ? largeTickRadius : smallTickRadius;
                var angleRadians = Math.toRadians(630 - (i * 360 / tickCount));
                var dotX = screenCenterX + (Math.cos(angleRadians) * goalMeterRadius).toNumber();
                var dotY = screenCenterY - (Math.sin(angleRadians) * goalMeterRadius).toNumber();
                dc.setColor(tickFillColor, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(dotX, dotY, radius);
                if (goalPercent < 1) {
                    dc.setColor(goalColor, Graphics.COLOR_TRANSPARENT);
                    dc.drawCircle(dotX, dotY, radius);
                }
            }
        }        
        
        // Draw goal value.
        dc.setColor(goalColor, backgroundColor);
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
    private var goalTypeName;
    private var goalColorName;
    private var goalMeterRadius;
    private var tickCount;
    private var largeTickRadius;
    private var smallTickRadius;
    private var largeTickFrequency;
    private var textY;
    private var current;
    private var goal;
}
