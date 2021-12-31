using Helpers;
using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;

class TimeDrawable extends OrbitDrawable {
    function initialize(params) {
        OrbitDrawable.initialize(params);
        font = WatchUi.loadResource(Rez.Fonts.TimeFont);
        secondsRadius = Helpers.minimum(screenWidth, screenHeight) / 2 - secondsPenWidth;
    }
    
    public function draw(dc) {
        var time = System.getClockTime();

        var hour = time.hour;       
        if (!System.getDeviceSettings().is24Hour) {
            if (hour == 0) {
                hour = 12;
            }
            if (hour > 12) {
                hour = hour - 12;
            }
        }

        // Draw hours.
        dc.setColor(getColor(Properties.hoursColor), Graphics.COLOR_TRANSPARENT);
        dc.drawText(screenCenterX, screenCenterY, font, hour, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw minutes.
        dc.setColor(getColor(Properties.minutesColor), Graphics.COLOR_TRANSPARENT);
        dc.drawText(screenCenterX, screenCenterY, font, time.min.format("%02d"), Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw seconds.
        drawSeconds(dc, false);
    }
    
    public function drawSeconds(dc, partialUpdate) {
        if (Application.Properties.getValue(Properties.showSeconds)) {
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
                        
                dc.setColor(getColor(Properties.secondsColor), Graphics.COLOR_TRANSPARENT);
                dc.setPenWidth(secondsPenWidth);
                dc.drawArc(screenCenterX, screenCenterY, secondsRadius, Graphics.ARC_CLOCKWISE, secAngleStart, secAngleEnd);
            }
        }
    }

    private var font;    
    private var secondsRadius;
    private const secondsPenWidth = 5;
}
