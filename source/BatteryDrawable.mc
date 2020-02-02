using Toybox.System;
using Toybox.WatchUi;

class BatteryDrawable extends OrbitDrawable {
    function initialize(params) {
        OrbitDrawable.initialize(params);
        font = WatchUi.loadResource(Rez.Fonts.BatteryFont);
        batteryY = params[:batteryY];       
    }
    
    function draw(dc) {
        var stats = System.getSystemStats();
        var batteryPercent = Lang.format("$1$%", [stats.battery.toNumber()]);
        var batteryColor = getColor(Properties.batteryColor);

        dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        
        // Draw battery percent.
        dc.drawText(
            screenCenterX + batteryPadding,
            batteryY,
            font,
            batteryPercent,
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // Draw battery.
        dc.setColor(stats.battery < 25 ? Graphics.COLOR_DK_RED : Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(
            screenCenterX - batteryPadding - batteryWidth,
            batteryY - (batteryHeight / 2),
            (batteryWidth - (batteryWidth / 8)) * stats.battery / 100,
            batteryHeight);
        dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(
            screenCenterX - batteryPadding - batteryWidth,
            batteryY - (batteryHeight / 2),
            batteryWidth - (batteryWidth / 8),
            batteryHeight);
        dc.drawRectangle(
            screenCenterX - batteryPadding - (batteryWidth / 8),
            batteryY - (batteryHeight / 3),
            batteryWidth / 8,
            batteryHeight * 2 / 3);
    }

    private var font;    
    private var batteryY;
    private const batteryWidth = 20;
    private const batteryHeight = 10;
    private const batteryPadding = 2;
}
