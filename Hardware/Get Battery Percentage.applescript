set batteryPercent to do shell script "pmset -g batt | awk '/InternalBattery/ { sub(/;/, \"\"); print $2 }'"

display dialog "Battery is " & batteryPercent & " charged." buttons {"OK"} default button "OK"
