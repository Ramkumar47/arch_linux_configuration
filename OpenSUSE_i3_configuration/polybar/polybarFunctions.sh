#!/bin/zsh
# function definitions for polybar custom modules

# used memory function
function memoryModule()
{
    memoryUsed=`free -m | awk '/^Mem:/{printf("%3.0f",($2 - $7)/$2*100)}'`

    if (( $memoryUsed < 40 ))   # safe limit
    then
    print $memoryUsed"%"
    elif (( $memoryUsed >= 40 && $memoryUsed < 80 )) # warning limit
    then
    print "%{F#ffff00}"$memoryUsed"%"
    else                # overload limit
    print "%{F#ff0000}"$memoryUsed"%"
    fi

}

# show memory-intensive-process function
function showMIP()
{
    mip=`ps axch -o cmd,%mem --sort=-%mem | head -n 10`
    notify-send -u low "$(echo "Processes: \t\t Percentage:\n\n"$mip)"
}

# used cpu function
function cpuModule()
{
    cpuUsed=`cat /proc/stat | grep "cpu" | head -n 1 | awk '{printf("%3.0f",($2+$4)/$5*100)}' `

    if (( $cpuUsed < 40 ))
    then            # safe limit
        print $cpuUsed"%"
    elif (( $cpuUsed >= 40 && $cpuUsed < 80 ))
    then            # warn limit
        print "%{F#ffff00}"$cpuUsed"%"
    else            # overload limit
        print "%{F#ff0000}"$cpuUsed"%"
    fi
}

# show cpu-intensive-process function------------------------------------------
function showCIP()
{
    cip=`ps axch -o cmd,%cpu --sort=-%cpu | head -n 10` # cpu intensive processes list
    ccp=`cat /proc/stat | grep "cpu" | tail -n +2 | awk '{printf("%s:\t %3.0f%\n",$1,($2+$34)/$5*100)}'` # core-wise usage percentage
    cct=`sensors | awk '/^Core/{print $3}'` # core-wise temperature

    # copying the output to a temporary file for horizontal concatenation
    echo $ccp > /tmp/ccp
    echo $cct > /tmp/cct

    cco=`paste /tmp/ccp /tmp/cct` # core-wise output

    notify-send -u low "$(echo "Cores: \t Percent  Temperature: \n\n"$cco"\n\n\t-----------------\n\nProcesses: \t\t Percentage:\n\n"$cip)"
}

# custom wifi function---------------------------------------------------------
function wirelessFunction()
{
    # reporting the wifi down status
    if [[ "$(cat /sys/class/net/wlp0s29f7u4/operstate)" = 'down' ]]; then
    # echo "down"
    echo "%{F#777777}ﲁ wifi down"
    exit
    fi

    # retrieving wifi strength
    QUALITY=$(grep "wlp0s29f7u4" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

    # retrieving wifi ssid name
    SSID=$(iw dev | grep "ssid" | awk '{print $2}')

    # reporting wifi on status
    echo "%{F#ffffff}說 "$QUALITY"% %{F#00ff00}"$SSID
}

# compositor toggle function---------------------------------------------------
function CompositorToggler()
{
    if [[ $1 == "enable" ]]
    then
    nice -n19 picom&
    disown
    echo "started"
    elif [[ $1 == "disable" ]]
    then
    pkill picom
    echo "killed"
    else
    echo "invalid Option"
    fi
}

# caps lock key notification function------------------------------------------
function CapsLockNotifier()
{
    option=`xset q | grep 00: | awk '{print $4}'`

    if [[ $option == "off" ]]
    then
        print ""
    elif [[ $option == "on" ]]
    then
        print "%{B#ff0000}%{F#000000} Caps ON "
    fi
}

# sound module notification function-------------------------------------------
function SoundNotifier()
{
    volume=`amixer sget Master | awk '(NR == 5){print $4}'`
    stat=`amixer sget Master | awk '(NR == 5){print $6}'`

    volume=`echo $volume | cut -d "[" -f 2 | cut -d "]" -f 1`
    stat=`echo $stat | cut -d "[" -f 2 | cut -d "]" -f 1`

    # echo $volume $stat

    if [[ $stat == "on" ]]
    then
        echo "蓼 "$volume
    elif [[ $stat == "off" ]]
    then
     echo "%{F#777}遼 muted"
    fi

    # click-toggle
    if [[ $1 == "clickToggle" ]]
    then
    amixer sset Master toggle
    polybar-msg hook SoundModule 1
    fi

}

## replaced with python script for better control
# # battery function definition--------------------------------------------------
# function BatteryModule()
# {
#     # getting battery percentage
#     percentage=`upower -i $(upower -e | grep -i "battery") | grep "percentage" | awk '{print $2}'`
#     # getting battery state
#     state=`upower -i $(upower -e | grep -i "battery") | grep "state" | awk '{print $2}'`
#
#     value=`echo $percentage | cut -d "%" -f 1`
#
#     # # fixing conditions
#     # if [[ $value == 20  &&  $state=="discharging" ]]
#     # then
#     #     echo "%{F#ff0}"$percentage
#     #     notify-send -u "normal" "Battery down to 20%"
#     # elif [[ $value < 6 && $state=="discharging" ]]
#     # then
#     #     echo "%{F#f00}"$percentage
#     #     notify-send -u "critical" "Battery down to 5%"
#     # elif [[ $value < 100 && $state=="charging" ]]
#     # then
#     #     echo "%{F#00f}"$percentage
#     # elif [[ $value == 100 && $state=="fully" ]]
#     # then
#     #     echo "%{F#0f0}"$percentage
#     #     notify-send -u "normal" "Battery is full"
#     # else
#     #     echo "%{F#fff}"$percentage
#     # fi
#
#     # # fixing conditions
#     # if (( $value < 21 && $value > 5 ))
#     # then
#     #     if [[ $state=="discharging" ]]
#     #     then
#     #         echo "%{F#ff0}"$percentage
#     #     else
#     #         echo "%{F#00f}"$percentage
#     #     fi
#     # elif (( $value < 6 ))
#     # then
#     #     if [[ $state=="discharging" ]]
#     #     then
#     #         echo "%{F#f00}"$percentage
#     #         notify-send -u "critical" "Battery down to 5%"
#     #     else
#     #         echo "%{F#00f}"$percentage
#     #     fi
#     # elif (( $value < 100 ))
#     # then
#     #     if [[ $state=="discharging" ]]
#     #     then
#     #         echo "%{F#fff}"$percentage
#     #     else
#     #         echo "%{F#00f}"$percentage # charging
#     #     fi
#     # elif (( $value == 100 ))
#     # then
#     #     if [[ $state=="discharging" ]]
#     #     then
#     #         echo "%{F#fff}"$percentage
#     #     else
#     #         echo "%{F#0f0}"$percentage # fully charged
#     #         notify-send -u "normal" "Battery is full"
#     #     fi
#     # fi
#
#     # python3 -c "from script import *; BatteryModule()"
#
# }

# battery time left indicator--------------------------------------------------
function showBatteryTime()
{
    # getting time
    stat=`upower -i $(upower -e | grep -i "battery") | grep "time"`

    # sending notification
    notify-send -u "low" $stat
}
"$@"                # line to call functions from terminal
