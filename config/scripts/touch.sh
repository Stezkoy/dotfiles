#!/bin/bash

STATE_FILE="/tmp/toggle_touch.txt"
if [ -f "$STATE_FILE" ]; then
    STATE=$(cat "$STATE_FILE")

    if [ "$STATE" = "enabled" ]; then
        notify-send -i "/usr/share/icons/Papirus/48x48/devices/input-touchpad.svg" "Touchpad" "Сенсорная панель выключена"
        hyprctl keyword 'device[htix5288:00-0911:5288-touchpad]:enabled' 'false'
        echo "disabled" > "$STATE_FILE"
    else
        notify-send -i /usr/share/icons/Papirus/48x48/devices/input-touchpad.svg "Touchpad" "Сенсорная панель включена"
        hyprctl keyword 'device[htix5288:00-0911:5288-touchpad]:enabled' 'true'
        echo "enabled" > "$STATE_FILE"
    fi
else
    notify-send -i /usr/share/icons/Papirus/48x48/devices/input-touchpad.svg "Touchpad" "Сенсорная панель включена"
    hyprctl keyword 'device[htix5288:00-0911:5288-touchpad]:enabled' 'true'
    echo "enabled" > "$STATE_FILE"
fi

