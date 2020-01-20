using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;

class BackgroundDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);
    }
    
    public function draw(dc) {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Application.Properties.getValue(Properties.backgroundColor));
        dc.clear();
    }
}
