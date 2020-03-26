#!/bin/sh

# DWM status bar configuration by SBCT;
# https://notabug.org/sabactani/dotfiles

Memory(){
      mem=$(free -mh | awk '{print $3}' | sed -n '2p' | sed "s/Gi/ GiB/")
      echo -en "\ue021$mem"
} 

Clock() { 
      clock=$(date "+%d/%m/%Y %H:%M")
      echo -en "\ue266$clock"
}

Disk() {
      space=$(grep /dev/sda7 <<< "$(df -h)" | awk  '{print $4}')
      echo -en "\ue1bb$space"
}

MPD(){
     song=$(mpc current)

     if [ -z "$song" ]; then
      echo ''
      else
      echo -e "\ue1a6$song |"
     fi
}

Battery(){
    batlvl=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ $(cat /sys/class/power_supply/BAT0/status) = "Discharging" ]; then
	   batic="\ue238"
    else
	   batic="\ue239"
    fi
    echo -e "$batic$batlvl%"
}

Vol(){
    vol=$(amixer get Master | grep -o -E [[:digit:]]+%)
    mutvol=$(amixer get Master | tail -1 | awk '{print $6}')
    
    if [ "$mutvol" = "[off]" ]; then
    echo -e "\ue04f$vol" 
    else
    echo -e "\ue05d$vol"
   fi
}

Weather() {
cat ~/.dwm/weather.txt
}

while :; do
	xsetroot -name "$(MPD) $(Disk) | $(Memory) | $(Vol) | $(Battery) | $(Weather)°C | $(Clock)"
      sleep 1 
done 


