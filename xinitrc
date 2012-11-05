#!/bin/sh

# Set Wireless IntelliMouse Explorer 2.0
imwheel -k -b "89"

# Numlock on
xsetnumlock

# Sleep after three minutes of inactivity
xset dpms 180 180 180

# Hide mouse cursor after five seconds of inactivity
unclutter &

# Set mouse pointer
xsetroot -cursor_name left_ptr

# Enable compose key: http://en.wikipedia.org/wiki/Compose_key#Common_compose_combinations
setxkbmap -option compose:menu

# Read configuration options
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start xmonad with custom script
/home/arrakis/scripts/run-xmonad.sh
