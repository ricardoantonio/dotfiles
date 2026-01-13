#!/usr/bin/env bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.ABC') LABEL='EN' ;;
'com.apple.keylayout.LatinAmerican') LABEL='LA' ;;
esac

sketchybar --set $NAME label=" $LABEL"
