using Toybox.System;
using Toybox.WatchUi;

class BatteryDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();
        batteryX = settings.screenWidth / 2;
        batteryY = settings.screenHeight / 8 + 6;       
    }
    
    function draw(dc) {
        var stats = System.getSystemStats();
        var batteryPercent = Lang.format("$1$%", [stats.battery.toNumber()]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        
        // Draw battery percent.
        dc.drawText(
            batteryX + batteryPadding,
            batteryY,
            Graphics.FONT_XTINY,
            batteryPercent,
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Draw battery.
        dc.drawRectangle(
            batteryX - batteryPadding - batteryWidth,
            batteryY - (batteryHeight / 2),
            batteryWidth - (batteryWidth / 8),
            batteryHeight);
        dc.drawRectangle(
            batteryX - batteryPadding - (batteryWidth / 8),
            batteryY - (batteryHeight / 2) + (batteryHeight / 8),
            batteryWidth / 8,
            batteryHeight * 3 / 4);
    }
    
    private var batteryX;
    private var batteryY;
    private const batteryWidth = 20;
    private const batteryHeight = 10;
    private const batteryPadding = 2;
}
