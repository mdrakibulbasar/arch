#!/bin/bash

WALLPAPER_DIR="/home/rakib/Downloads/Img/wallpaper/"


WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) -print0 | xargs -0 -I {} basename {} | sort)

SELECTED_WALLPAPER=$(echo -e "$WALLPAPERS" | wofi --show dmenu -i -p "Wallpaper:" --width 300)

declare -a transitions=("grow" "outer" "any" "fade" "wipe" "wave" "center" "simple")

RANDOM_TRANSITION=${transitions[$((RANDOM % ${#transitions[@]}))]}

if [ -n "$SELECTED_WALLPAPER" ]; then
	# Construct the full path to the selected wallpaper
	FULL_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER"

	# Use swww to set the wallpaper
	swww img "$FULL_PATH" \
	  --transition-type "$RANDOM_TRANSITION" \
	  --transition-duration 0.5 \
	  --transition-fps 60
fi
