using Toybox.ActivityMonitor;
using Toybox.System;
using Toybox.WatchUi;

class GoalDrawable extends OrbitDrawable {
    function initialize(params) {
        OrbitDrawable.initialize(params);
        font = WatchUi.loadResource(Rez.Fonts.GoalFont);
        iconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
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
        
        var goalColor = getColor(goalColorName);
        var backgroundColor = getColor(Properties.backgroundColor);

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
        var goalTypeString = goalType.toString();
        var currentString = current.toString();
        var iconWidth = dc.getTextWidthInPixels(goalTypeString, iconFont);
        var valueWidth = dc.getTextWidthInPixels(currentString, font);
        var startX = screenCenterX - ((iconWidth + valueWidth) / 2);
        
        dc.setColor(goalColor, backgroundColor);
        dc.drawText(startX, textY, iconFont, goalTypeString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(startX + iconWidth, textY, font, currentString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function setGoalValues(current, goal, goalType) {
        self.current = current;
        self.goal = goal;
        self.goalType = goalType;
    }
    
    private var font;
    private var iconFont;
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
    private var goalType;
}
