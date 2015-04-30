#!/bin/sh
if [ $(pacmd list-sinks | grep "muted:" | awk '{print $2}') = "no" ]; then
	vol="$(pacmd list-sinks | grep "volume: 0:"| awk '{print $3}')"
	echo "vol: $vol"
else
	echo "mute!"
fi
