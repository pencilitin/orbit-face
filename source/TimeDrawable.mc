using Helpers;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;

class TimeDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();      
        screenWidth = settings.screenWidth;
        screenHeight = settings.screenHeight;
        screenCenterX = screenWidth / 2;
        screenCenterY = screenHeight / 2;
        secondsRadius = Helpers.minimum(screenWidth, screenHeight) / 2 - secondsPenWidth;
    }
    
    public function draw(dc) {
        var time = System.getClockTime();

        var hour = time.hour;       
        if (!System.getDeviceSettings().is24Hour && hour > 12) {
            hour = hour - 12;
        }

        // Draw hours.
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_NUMBER_THAI_HOT,
            hour,
            Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw minutes.
        dc.setColor(Graphics.COLOR_PURPLE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_SYSTEM_NUMBER_THAI_HOT,
            time.min.format("%02d"),
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw seconds.
        drawSeconds(dc, false);
    }
    
    public function drawSeconds(dc, partialUpdate) {
        var time = System.getClockTime();
        if (time.sec > 0) {
            var secAngleEnd = 450 - (time.sec * 6);
            var secAngleStart = 90;
            if (partialUpdate) {
                var secAngleEndRadians = Math.toRadians(secAngleEnd);
                var secAngleEndX = screenCenterX + (Math.cos(secAngleEndRadians) * secondsRadius).toNumber();
                var secAngleEndY = screenCenterY - (Math.sin(secAngleEndRadians) * secondsRadius).toNumber();
                secAngleStart = secAngleEnd + 6;
                var secAngleStartRadians = Math.toRadians(secAngleStart);
                var secAngleStartX = screenCenterX + (Math.cos(secAngleStartRadians) * secondsRadius).toNumber();
                var secAngleStartY = screenCenterY - (Math.sin(secAngleStartRadians) * secondsRadius).toNumber();
                
                var x = Helpers.minimum(secAngleStartX, secAngleEndX) - (secondsPenWidth + 2);
                var y = Helpers.minimum(secAngleStartY, secAngleEndY) - (secondsPenWidth + 2);
                var width = (secAngleStartX - secAngleEndX).abs() + ((secondsPenWidth + 2) * 2);
                var height = (secAngleStartY - secAngleEndY).abs() + ((secondsPenWidth + 2) * 2);
        
                dc.setClip(x, y, width, height);
            }
                    
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            dc.setPenWidth(secondsPenWidth);
            dc.drawArc(
                screenCenterX,
                screenCenterY,
                secondsRadius,
                Graphics.ARC_CLOCKWISE,
                secAngleStart,
                secAngleEnd);
        }
    }
    
    private var screenWidth;
    private var screenHeight;
    private var screenCenterX;
    private var screenCenterY;
    private var secondsRadius;
    private const secondsPenWidth = 5;
}
