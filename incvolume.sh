#!/bin/sh
if [ $(pacmd list-sinks | grep "volume: 0:"| awk '{print int($3)}') -le 95 ]; then
	pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%
fi
