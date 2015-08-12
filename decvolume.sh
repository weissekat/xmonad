#!/bin/sh
#if [ $(pacmd list-sinks | grep "index: 1" -A 1000 | grep "volume: front-left:"| awk '{print int($5}') -ge 5 ]; then
	pactl set-sink-mute 1 false ; pactl set-sink-volume 1 -- -5%
#fi
