#!/bin/bash

if [ "$#" -ne 1 ]; then
notify-send "Использование: $0 <путь_к_файлу>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    notify-send "Ошибка: файл не найден!"
    exit 1
fi

toggle_touchpad_setting() {
    BLOCK=$(sed -n '/touchpad {/,/}/p' "$FILE")
    
    if echo "$BLOCK" | grep -q "//off"; then
        sed -i '/touchpad {/,/}/s|//off|off|' "$FILE"
        notify-send -i "/usr/share/icons/Papirus/48x48/devices/input-touchpad.svg" "Touchpad" "Сенсорная панель выключена"
    elif echo "$BLOCK" | grep -q "off"; then
        sed -i '/touchpad {/,/}/s|off|//off|' "$FILE"
        notify-send -i /usr/share/icons/Papirus/48x48/devices/input-touchpad.svg "Touchpad" "Сенсорная панель включена"
    else
        notify-send "Настройка touchpad не найдена в блоке"
        exit 1
    fi
}

if grep -q "touchpad {" "$FILE"; then
    toggle_touchpad_setting
else
    notify-send "Блок настроек touchpad не найден в файле"
    exit 1
fi
