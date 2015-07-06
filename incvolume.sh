#!/bin/sh
if [ $(pacmd list-sinks | grep 'index: 1' -A 100 | grep "volume: 0:"| awk '{print int($3)}') -le 95 ]; then
	pactl set-sink-mute 1 false ; pactl set-sink-volume 1 +5%
fi
