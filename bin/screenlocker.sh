#!/usr/bin/env bash

lock() {
  tmpbg='/tmp/screen.png'

  (( $# )) && { icon=$1; }

  scrot "$tmpbg"
  convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
  i3lock -t -f -i "$tmpbg"
}
