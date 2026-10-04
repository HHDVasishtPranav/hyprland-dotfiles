#!/bin/sh
[ $(( $(date +%s) % 2 )) -eq 0 ] && printf '|' || printf ' '
