#!/bin/sh

Clock() {
    echo "$(date "+%H:%M - %d %b %Y (%a)")"
}

Volume() {
    if [ "$(pamixer --get-mute)" = "true" ]; then
        echo "MUTE"
    else
        pamixer --get-volume
    fi
}

prompt() {
    #echo "%{c}%{F#FFFF00}%{B#0000FF} $(Clock) %{F-}%{B-}"
    while :; do
        echo "$(Volume)%{c}$(Clock)"
        sleep 0.5
    done
}

draw() {
    prompt | \
        lemonbar \
        -f 'BigBlueTermPlus Nerd Font' \
        -g x24+0+0 \
        -b \
        -B '#FF000000' \
        -F '#FFAAAAAA'
}

draw
