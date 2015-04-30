#!/bin/sh
setxkbmap -query | grep "layout:" | awk '{print toupper($2)}'

