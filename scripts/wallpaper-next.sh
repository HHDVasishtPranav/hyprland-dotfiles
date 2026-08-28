#!/bin/bash

DIR="$HOME/Pictures/Wallpapers"
STATE="$DIR/.current"

mapfile -t WALLPAPERS < <(
    find "$DIR" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        | sort
)

[ ${#WALLPAPERS[@]} -eq 0 ] && exit 1

CURRENT=$(cat "$STATE" 2>/dev/null)
INDEX=-1

for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$CURRENT" ]]; then
        INDEX=$i
        break
    fi
done

NEXT=$(( (INDEX + 1) % ${#WALLPAPERS[@]} ))
NEW="${WALLPAPERS[$NEXT]}"

echo "$NEW" > "$STATE"

# Change wallpaper
hyprctl hyprpaper wallpaper "eDP-1,$NEW"

# Generate colors
"$HOME/.cargo/bin/matugen" image \
    --source-color-index 0 \
    "$NEW"
