#!/bin/sh
#if [ $(pacmd list-sinks | grep "volume: front-left:"| awk '{print $5}') -le "95%" ]; then
	pactl set-sink-mute 1 false ; pactl set-sink-volume 1 +5%
#fi
