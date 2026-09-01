#!/bin/sh
RESULT=$(nvidia-detect 2>&1)

if echo "$RESULT" | grep -q "nvidia-driver"; then
    RECOMMENDED=$(echo "$RESULT" | grep -oP 'nvidia-driver\S*' | head -1)
    if zenity --question \
        --title="Driver Manager" \
        --text="An NVIDIA GPU was detected.\n\nInstall the recommended proprietary driver ($RECOMMENDED)?\n\nThis gives better performance for gaming and graphics-heavy apps." \
        --width=400; then
        pkexec sh -c "apt update && apt install -y $RECOMMENDED"
        zenity --info --text="Driver installed. Please restart your computer for it to take effect." --width=300
    fi
else
    zenity --info --text="No proprietary NVIDIA driver needed — your system is already using the best available driver (or an open-source driver is sufficient for your hardware)." --width=350
fi
