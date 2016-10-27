#!/bin/sh
if [ $(pacmd list-sinks | grep 'index: 2' -A 100 | grep "volume: 0:"| awk '{print int($3)}') -ge 5 ]; then
	pactl set-sink-mute 2 false ; pactl set-sink-volume 2 -- -5%
fi
