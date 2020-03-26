#!/bin/sh

xset +fp $HOME/.local/share/fonts &
xset fp rehash &


exec setxkbmap br & # set keyboard mapping
exec hsetroot -center $HOME/wallpaper/bik.png & # set wallpaper
exec dunst &
exec mpdas & # turn on mpdas
exec $HOME/.dwm/weather & 
exec $HOME/.dwm/dwmbar.sh &
exec $HOME/.dwm/dwm/dwm

