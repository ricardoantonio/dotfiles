#!/bin/bash

# Obtener estado de Apple Music
STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)

if [ "$STATE" = "playing" ]; then
  # Obtener info de la canción
  TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)

  # Truncar si es muy largo
  MAX_LENGTH=35
  DISPLAY="$ARTIST - $TRACK"
  if [ ${#DISPLAY} -gt $MAX_LENGTH ]; then
    DISPLAY="${DISPLAY:0:$MAX_LENGTH}..."
  fi

  sketchybar --set "$NAME" \
    icon="󰎆 " \
    label="$DISPLAY" \
    drawing=on

else
  # Nada reproduciéndose, ocultar
  sketchybar --set "$NAME" drawing=off
fi
