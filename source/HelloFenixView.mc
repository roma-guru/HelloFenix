using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.ActivityMonitor;

class HelloFenixView extends WatchUi.WatchFace {
	
	var timeview, dateview, stepsview, floorsview, batteryview;
	var time_info, act_info, sys_info;

    function initialize() {
        WatchFace.initialize();
        self.time_info = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        self.act_info = ActivityMonitor.getInfo();
        self.sys_info = System.getSystemStats();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
           
        self.timeview = View.findDrawableById("TimeLabel");
        self.dateview = View.findDrawableById("DateLabel");
        self.stepsview = View.findDrawableById("StepsLabel");
        self.floorsview = View.findDrawableById("FloorsLabel");
        self.batteryview = View.findDrawableById("BatteryLabel"); 
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var dateString = Lang.format("$3$,$1$ de $2$", [time_info.day, time_info.month, time_info.day_of_week]);
        var timeString = Lang.format("$1$:$2$", [time_info.hour.format("%02d"), time_info.min.format("%02d")]);
        var stepsString = Lang.format("$1$/$2$", [act_info.steps, act_info.stepGoal]);
        var floorsString = Lang.format("$1$/$2$", [act_info.floorsClimbed, act_info.floorsClimbedGoal]);
        var batteryString = Lang.format("$1$%", [sys_info.battery.format("%02d")]);

        dateview.setText(dateString);
        timeview.setText(timeString);
        stepsview.setText(stepsString);
        floorsview.setText(floorsString);
        batteryview.setText(batteryString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
