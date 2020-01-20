using Toybox.System;
using Toybox.WatchUi;

class BatteryDrawable extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();
        batteryX = settings.screenWidth / 2;
        batteryY = params[:batteryY];       
    }
    
    function draw(dc) {
        var stats = System.getSystemStats();
        var batteryPercent = Lang.format("$1$%", [stats.battery.toNumber()]);
        var batteryColor = Application.Properties.getValue(Properties.batteryColor);

        dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        
        // Draw battery percent.
        dc.drawText(
            batteryX + batteryPadding,
            batteryY,
            Graphics.FONT_XTINY,
            batteryPercent,
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Draw battery.
        dc.setColor(stats.battery < 25 ? Graphics.COLOR_DK_RED : Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(
            batteryX - batteryPadding - batteryWidth,
            batteryY - (batteryHeight / 2),
            (batteryWidth - (batteryWidth / 8)) * stats.battery / 100,
            batteryHeight);
        dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(
            batteryX - batteryPadding - batteryWidth,
            batteryY - (batteryHeight / 2),
            batteryWidth - (batteryWidth / 8),
            batteryHeight);
        dc.drawRectangle(
            batteryX - batteryPadding - (batteryWidth / 8),
            batteryY - (batteryHeight / 3),
            batteryWidth / 8,
            batteryHeight * 2 / 3);
    }
    
    private var batteryX;
    private var batteryY;
    private const batteryWidth = 20;
    private const batteryHeight = 10;
    private const batteryPadding = 2;
}
