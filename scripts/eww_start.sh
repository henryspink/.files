#!/bin/bash
monitors=$(xrandr --listmonitors | grep "Monitors: ")
num_monitors=$(echo -n "$monitors" | tail -c 1)
num_monitors=$(($num_monitors + 0))
killall eww
eww kill
eww daemon
if [[ $num_monitors -gt 0 ]]; then
	eww open system_info_one
	eww open clockone
fi
if [[ $num_monitors -gt 1 ]]; then
	eww open clocktwo
fi
if [[ $num_monitors -gt 2 ]]; then
        eww open clockthree
fi
