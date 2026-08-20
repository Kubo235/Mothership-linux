#!/bin/sh
while ! pgrep -x xfdesktop > /dev/null; do
    sleep 1
done
sleep 2

WALLPAPER="/usr/share/backgrounds/mothership/Mothership-background.jpg"

# Set on any already-existing last-image properties (covers older/leftover configs)
for prop in $(xfconf-query -c xfce4-desktop -p /backdrop -lv 2>/dev/null | grep last-image | cut -d' ' -f1); do
    xfconf-query -c xfce4-desktop -p "$prop" -s "$WALLPAPER"
done

# Detect the REAL monitor name(s) and force-create properties for them
for mon in $(xrandr --listmonitors | tail -n +2 | awk '{print $NF}'); do
    for sub in "workspace0/last-image" "last-image" "workspace0/image-path" "image-path"; do
        prop="/backdrop/screen0/monitor${mon}/${sub}"
        xfconf-query -c xfce4-desktop -p "$prop" -n -t string -s "$WALLPAPER" 2>/dev/null || \
        xfconf-query -c xfce4-desktop -p "$prop" -s "$WALLPAPER" 2>/dev/null
    done
    xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor${mon}/workspace0/image-show" -n -t bool -s true 2>/dev/null
    xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor${mon}/image-show" -n -t bool -s true 2>/dev/null
    xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor${mon}/workspace0/image-style" -n -t int -s 5 2>/dev/null
    xfconf-query -c xfce4-desktop -p "/backdrop/screen0/monitor${mon}/image-style" -n -t int -s 5 2>/dev/null
done

xfdesktop --reload
