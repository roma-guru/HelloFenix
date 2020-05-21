using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.ActivityMonitor;
using Toybox.Math;

class HelloFenixView extends WatchUi.WatchFace {
    
    function initialize() {
        WatchFace.initialize();
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
        var time_info = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var act_info = ActivityMonitor.getInfo();
        var hrIterator = ActivityMonitor.getHeartRateHistory(3, false);
        var sys_info = System.getSystemStats();

        var dateString = Lang.format("$3$ $1$ $2$", [time_info.day, time_info.month, time_info.day_of_week]);
        var timeString = Lang.format("$1$:$2$", [time_info.hour.format("%02d"), time_info.min.format("%02d")]);
        var heartString = Lang.format("︎$1$bpm", [hrIterator.next().heartRate % 255]);
        
        var stepsAngle = 360.0 * act_info.steps/act_info.stepGoal;
        var floorsAngle = 360.0 * act_info.floorsClimbed/act_info.floorsClimbedGoal;
        var batteryAngle = 360.0 * sys_info.battery/100;
        
        // Display circles
        var w = 5, n = 0.5;
        var x_c = dc.getWidth()/2;
        var y_c = dc.getHeight()/2;
        var r = dc.getWidth()/2;
        dc.setPenWidth(w);
        
        self.drawCircle(dc, x_c, y_c, r - n*w, Graphics.COLOR_DK_GRAY, batteryAngle);
        n += 1.0;
        self.drawCircle(dc, x_c, y_c, r - n*w, Graphics.COLOR_DK_GREEN, floorsAngle);
        n += 1.0;
        self.drawCircle(dc, x_c, y_c, r - n*w, Graphics.COLOR_YELLOW, stepsAngle);
        
        // Display datetime and heartbeat
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.drawText(x_c, y_c, Graphics.FONT_NUMBER_HOT, timeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
        dc.drawText(x_c, y_c - r/2, Graphics.FONT_SMALL, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawText(x_c, y_c + r/4, Graphics.FONT_XTINY, heartString, Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    private function drawCircle(dc, x_c, y_c, r, color, angle) {
        if (angle > 0) {
            dc.setColor(color, Graphics.COLOR_BLACK);
            dc.drawArc(x_c, y_c, r, Graphics.ARC_COUNTER_CLOCKWISE, 90.0, 90.0+angle);
        }
    }
    
}
