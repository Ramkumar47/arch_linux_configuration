#!/bin/zsh
# function definitions for i3blocks custom modules

# used memory function
function memoryModule()
{
    # getting total, buffer, cached and free memories in kb
	total_mem=`grep '^MemTotal' /proc/meminfo | awk '{print $2}'`
	free_mem=`grep '^MemFree' /proc/meminfo | awk '{print $2}'`
	buffer_mem=`grep '^Buffers' /proc/meminfo | awk '{print $2}'`
	cache_mem=`grep '^Cached' /proc/meminfo | awk '{print $2}'`

	# computing used memory in kb
	used_mem=$((total_mem - free_mem - buffer_mem - cache_mem))

	# computing percentage of used memory
	memoryUsed=$((used_mem*100/total_mem))


	if (( $memoryUsed < 40 ))	# safe limit
	then
			printf ": %3.0f %%\n" $memoryUsed
			printf ": %3.0f %%\n" $memoryUsed
	elif (( $memoryUsed >= 40 && $memoryUsed < 80 )) # warning limit
	then
			printf ": %3.0f %%\n" $memoryUsed
			printf ": %3.0f %%\n" $memoryUsed
			echo "#ffff00"
	else				# overload limit
			printf ": %3.0f %%\n" $memoryUsed
			printf ": %3.0f %%\n" $memoryUsed
			echo "#ffffff"
			echo "#ff0000"
	fi

	case "$BLOCK_BUTTON" in
			1|2|3)
					i3-msg -q "exec zsh $HOME/.config/i3blocks/shellFunctions.sh showMIP"
    esac

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
	cpuIdle=`mpstat 1 1 | awk 'NR==5{printf("%3.1f", $12)}'`
	cpuUsed=$((100 - cpuIdle))

    if (( $cpuUsed < 40 ))
    then			# safe limit
			printf ":%2.0f %%\n" $cpuUsed
			printf ":%4.0f %%\n" $cpuUsed
    elif (( $cpuUsed >= 40 && $cpuUsed < 80 ))
    then			# warn limit
			printf ":%2.0f %%\n" $cpuUsed
			printf ":%4.0f %%\n" $cpuUsed
			echo "#ffff00"
    else			# overload limit
			printf ":%2.0f %%\n" $cpuUsed
			printf ":%4.0f %%\n" $cpuUsed
			echo "#ffffff"
			echo "#ff0000"
    fi

	case "$BLOCK_BUTTON" in
			1|2|3)
					i3-msg -q "exec zsh $HOME/.config/i3blocks/shellFunctions.sh showCIP"
    esac

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

# custom wifi function
function wirelessFunction()
{
    # reporting the wifi down status
    if [[ "$(cat /sys/class/net/wlan0/operstate)" = 'down' ]]; then
		echo "睊down"
		echo "睊down"
		echo "#444"
    else

		# retrieving wifi strength: reference - wifi module from https://github.com/vivien/i3blocks-contrib
		QUALITY=$(iw dev wlan0 link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')

		# retrieving wifi ssid name
		SSID=$(iw dev | grep "ssid" | awk '{print $2}')
		# reporting wifi on status
		echo "直"$SSID" "$QUALITY"%"
		echo "直"$SSID" "$QUALITY"%"

	fi

	case "$BLOCK_BUTTON" in
			1|2|3)
					i3-msg -q "exec notify-send -u low \"\$(iw dev wlan0 link)\""
	esac
}

# caps lock key notification function
function CapsLockNotifier()
{
    option=`xset q | grep 00: | awk '{print $4}'`

    if [[ $option == "off" ]]
    then
			echo ""
    elif [[ $option == "on" ]]
    then
			echo "Caps ON"
			echo "Caps ON"
			echo "#ffffff"
			echo "#ff0000"
    fi
}

# sound module notification function
function SoundNotifier()
{
    volume=`amixer sget Master | awk '(NR == 5){print $4}'`
    stat=`amixer sget Master | awk '(NR == 5){print $6}'`

    volume=`echo $volume | cut -d "[" -f 2 | cut -d "]" -f 1 | cut -d '%' -f 1`
    stat=`echo $stat | cut -d "[" -f 2 | cut -d "]" -f 1`

	if [[ $stat == "on" ]]
	then
		if (( $volume < 40 ))
		then
			printf " %d %%\n" $volume
			printf " %d %%\n" $volume
		elif (( $volume >= 40 && $volume < 70 ))
		then
			printf " %d %%\n" $volume
			printf " %d %%\n" $volume
	    else
			printf " %d %%\n" $volume
			printf " %d %%\n" $volume
		fi
	elif [[ $stat == "off" ]]
	then
		echo " mute"
		echo " mute"
		echo "#777777"
	fi

	case "$BLOCK_BUTTON" in
			1|2|3)
				i3-msg -q "exec amixer sset Master toggle; exec pkill -SIGRTMIN+11 i3blocks"
    esac

}

# disk usage module function
function diskUsage()
{
	# getting root disk use percentage
	rootPercentage=`df | grep '/$' | awk '{print $5}' | cut -d '%' -f 1`
	# getting home disk use percentage
	homePercentage=`df | grep '/home$' | awk '{print $5}' | cut -d '%' -f 1`

	# printing output
	printf " %2.0f %%   %2.0f %%\n" $rootPercentage $homePercentage
	printf " %2.0f %%   %2.0f %%\n" $rootPercentage $homePercentage
}

# calendar and date time function
function dateTime()
{
    echo $(date '+%d-%h-%y %_I:%M:%S %p')

	case "$BLOCK_BUTTON" in
			1|2|3)
					i3-msg -q "exec gsimplecal"
	esac
}

# ethernet connection function
function ethernetFunction()
{
		# getting state of ethernet port
		state=`cat /sys/class/net/enp3s0/operstate`

		if [[ $state == "down" ]]
		then
				echo "lan down"
				echo "lan down"
				echo "#444"
		elif [[ $state == "up" ]]
		then
				echo "lan up"
				echo "lan up"
				echo "#0f0"
		fi
}

"$@"				# line to call functions from terminal
