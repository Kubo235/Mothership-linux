#!/bin/sh
CHOICE=$(zenity --list \
    --title="Mothership" \
    --text="Choose an option" \
    --column="Action" \
    "Task Manager" "Lock Screen" "Sign Out" "Restart" "Shut Down" \
    --height=300 --width=250)

case "$CHOICE" in
    "Task Manager") xfce4-taskmanager ;;
    "Lock Screen") xflock4 ;;
    "Sign Out") xfce4-session-logout --logout ;;
    "Restart") xfce4-session-logout --reboot ;;
    "Shut Down") xfce4-session-logout --halt ;;
esac
