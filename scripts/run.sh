#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
xset r rate 200 50 &

bash ~/.config/dwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
