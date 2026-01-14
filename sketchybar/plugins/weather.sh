#!/usr/bin/env bash

set -a
source "$HOME/.config/.env"
set +a

# WTTR_LOCATION="LAT,LON"
LAT="${WTTR_LOCATION%,*}"
LON="${WTTR_LOCATION#*,}"
[ -z "$LAT" ] || [ -z "$LON" ] && exit 0

weather_data=$(curl -sL "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current_weather=true")
cw=$(echo "$weather_data" | grep -o '"current_weather":{[^}]*}')
temp=$(echo "$cw" | grep -o '"temperature":[0-9.-]*' | cut -d':' -f2)
code=$(echo "$cw" | grep -o '"weathercode":[0-9]*' | cut -d':' -f2)
is_day=$(echo "$cw" | grep -o '"is_day":[01]' | cut -d':' -f2)

temp=$(printf "%.0f" "${temp:-0}")

# Iconos con día/noche
case "$code" in
0) [ "$is_day" -eq 1 ] && icon="􀆮" || icon="􀇁" ;;       # Clear: day/night
1 | 2) [ "$is_day" -eq 1 ] && icon="􀇕" || icon="􀇛" ;;   # Partly cloudy: day/night
3) icon="􀇃" ;;                                          # Overcast
45 | 48) icon="􀇋" ;;                                    # Fog
51 | 53 | 55 | 61 | 63 | 65 | 80 | 81 | 82) icon="􀇇" ;; # Rain
71 | 73 | 75 | 77 | 85 | 86) icon="􀇏" ;;                # Snow
95 | 96 | 99) icon="􀇓" ;;                               # Thunderstorm
*) icon="􀁝" ;;                                          # Unknown
esac

sketchybar --set weather icon="$icon" label="${temp}°"
