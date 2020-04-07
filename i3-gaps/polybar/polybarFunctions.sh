#!/bin/zsh
# function definitions for polybar custom modules

# used memory function
function memoryModule()
{
    memoryUsed=`free -m | awk '/^Mem:/{printf("%3.0f",($2 - $7)/$2*100)}'`

    if (( $memoryUsed < 40 ))	# safe limit
    then
	print $memoryUsed"%"
    elif (( $memoryUsed >= 40 && $memoryUsed < 80 )) # warning limit
    then
	print "%{F#ffff00}"$memoryUsed"%"
    else				# overload limit
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
    then			# safe limit
	print $cpuUsed"%"
    elif (( $cpuUsed > 40 && $cpuUsed < 80 ))
    then			# warn limit
	print "%{F#ffff00}"$cpuUsed"%"
    else			# overload limit
	print "%{F#ff0000}"$cpuUsed"%"
    fi
}

# show cpu-intensive-process function
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

# cutom wifi function
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

"$@"				# line to call functions from terminal
