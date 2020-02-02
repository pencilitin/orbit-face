using Toybox.System;

class BackgroundDrawable extends OrbitDrawable {
    function initialize(params) {
        OrbitDrawable.initialize(params);
    }
    
    public function draw(dc) {
        dc.setColor(Graphics.COLOR_TRANSPARENT, getColor(Properties.backgroundColor));
        dc.clear();
    }
}
