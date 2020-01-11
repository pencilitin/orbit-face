using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;

class DateDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();
        dateX = settings.screenWidth / 2;
        dateY = settings.screenHeight / 4;      
    }
    
    function draw(dc) {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$ $2$ $3$", [today.day_of_week, today.day, today.month]);
        
        // Draw date.
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dateX,
            dateY,
            Graphics.FONT_TINY,
            date,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    private var dateX;
    private var dateY;
}
