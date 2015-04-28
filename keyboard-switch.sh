#!/bin/sh
case $(setxkbmap -query | grep "layout" | awk '{print $2}') in
	"us") setxkbmap ru; xset led named "Scroll Lock";;
	*) setxkbmap us; xset -led named "Scroll Lock";;
esac
