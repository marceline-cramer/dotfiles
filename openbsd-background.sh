#!/bin/ksh

BG_PATH=/usr/local/share/openbsd-backgrounds
BG_FILE=$(cat "$BG_PATH/landscape.list" | sort -R | head -n1)
echo "$BG_FILE"
basename "$BG_FILE" .jpg > /tmp/background
swaybg -m fill -i "$BG_PATH/$BG_FILE"
