#!/bin/sh
if [ $(pacmd list-sinks | grep 'index: 2' -A 100 | grep "muted:" | awk '{print $2}') = "no" ]; then
	vol="$(pacmd list-sinks | grep 'index: 2' -A 100 | grep "volume: 0:"| awk '{print $3}')"
	echo "vol: <fc=green>$vol</fc>"
else
	echo "vol: <fc=red>mute</fc>"
fi
