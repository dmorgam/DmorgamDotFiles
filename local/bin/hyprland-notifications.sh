#!/bin/sh
#
# Control de sonido y demas para hyprland con waybar
#


# ---- Variables -----------------------------------
NOTIFY_DIR="/tmp/hyprland-notify"

NOTIFY_AUDIO_ID_FILE="$NOTIFY_DIR/audio_notify"
NOTIFY_MIC_ID_FILE="$NOTIFY_DIR/mic_notify"
NOTIFY_LIGHT_ID_FILE="$NOTIFY_DIR/light_notify"

VOL_SOUND="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"

# ---- Functions -----------------------------------

configure_audio () {

    if [ "$1" = "mute" ]
    then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        MUTE="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
    else
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$1"
    fi

    VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ |
          awk '{print int($2 * 100)}')

    if [ -f "$NOTIFY_AUDIO_ID_FILE" ] && [ -s "$NOTIFY_AUDIO_ID_FILE" ]
    then
        NOTIFY_ID=$(cat "$NOTIFY_AUDIO_ID_FILE")
    else
        NOTIFY_ID=0
    fi

    notify-send -t 1000 -p -r "$NOTIFY_ID" \
                --hint=int:value:"$VOL" " $MUTE" > $NOTIFY_AUDIO_ID_FILE

    paplay "$VOL_SOUND"
}

configure_mic () {

    if [ "$1" = "mute" ]
    then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        MIC="$(wpctl get-volume @DEFAULT_AUDIO_SINK@) [toggle-mute]"
    fi

    if [ -f "$NOTIFY_MIC_ID_FILE" ] && [ -s "$NOTIFY_MIC_ID_FILE" ]
    then
        NOTIFY_ID=$(cat "$NOTIFY_MIC_ID_FILE")
    else
        NOTIFY_ID=0
    fi

    notify-send -t 1000 -p -r "$NOTIFY_ID" "󰍬  $MIC"
}

configure_light () {

    brightnessctl s "$1"
    BRIGHT=$(brightnessctl info |
             head -n 2 | tail -n 1 | cut -d'(' -f 2 | cut -d'%' -f 1)

    if [ -f "$NOTIFY_LIGHT_ID_FILE" ] && [ -s "$NOTIFY_LIGHT_ID_FILE" ]
    then
        NOTIFY_ID=$(cat "$NOTIFY_LIGHT_ID_FILE")
    else
        NOTIFY_ID=0
    fi

    notify-send -t 1000 -p -r "$NOTIFY_ID" \
                --hint=int:value:"$BRIGHT" "󰃟 " > $NOTIFY_LIGHT_ID_FILE
}

# ---- Main ----------------------------------------
mkdir -p $NOTIFY_DIR

case "$1" in
  "audio")
    configure_audio "$2"
    ;;
  "light")
    configure_light "$2"
    ;;
  "mic")
    configure_mic "$2"
    ;;
esac
