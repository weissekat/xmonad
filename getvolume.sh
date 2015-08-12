#!/bin/sh
if [ $(pacmd list-sinks | grep "index: 1" -A 1000 | grep "muted:" | awk '{print $2}') = "no" ]; then
	vol="$(pacmd list-sinks | grep "index: 1" -A 1000 | grep "volume: front-left: "| awk '{print $5}')"
	echo "<fc=green>$vol</fc>"
else
	echo "<fc=red>mute</fc>"
fi
