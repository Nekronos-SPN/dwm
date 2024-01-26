#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. /home/nekronos/.config/dwm/scripts/bar_themes/onedark

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  printf "^c$blue^   $get_capacity 󰏰"
}

mem() {
  mem_val=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
  printf "^c$black^ ^b$red^ MEM"
  printf "^c$white^ ^b$grey^ $mem_val"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) 
		ip_addr=$(ip addr show wlp3s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') ;
		printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$green^$ip_addr" ;;
	down) 
		printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%H:%M')  "
}

while true; do

  interval=$((interval + 1))

  sleep 1 && xsetroot -name "       GENTOO $(battery) $(cpu) $(mem) $(wlan) $(clock)"
done
