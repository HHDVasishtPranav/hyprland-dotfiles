#!/usr/bin/env bash

player="$(playerctl -l 2>/dev/null | while read -r name; do
    [ "$(playerctl --player="$name" status 2>/dev/null)" = "Playing" ] && { printf '%s' "$name"; break; }
done)"

[ -n "$player" ] || exit 0
title="$(playerctl --player="$player" metadata --format '{{ title }}' 2>/dev/null)"
artist="$(playerctl --player="$player" metadata --format '{{ artist }}' 2>/dev/null)"
text="${title}${artist:+ — $artist}"
[ "${#text}" -gt 48 ] && text="${text:0:47}…"
printf '󰎆 %s\n' "$text"
