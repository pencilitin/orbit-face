using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DateDrawable extends OrbitDrawable {
    function initialize(params) {
        OrbitDrawable.initialize(params);
        dateY = params[:dateY];      
    }
    
    function draw(dc) {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$ $2$", [today.day_of_week, today.day]);
        
        // Draw date.
        dc.setColor(getColor(Properties.dateColor), Graphics.COLOR_TRANSPARENT);
        dc.drawText(screenCenterX, dateY, Graphics.FONT_TINY, date, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    private var dateY;
}
