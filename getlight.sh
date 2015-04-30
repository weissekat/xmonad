#!/bin/sh
light="$(xbacklight -get | awk '{print int($1 + 0.5)}')"
echo "light: <fc=green>$light%</fc>"
