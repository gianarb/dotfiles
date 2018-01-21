#!/usr/bin/env bash

lock() {
  tmpbg='/tmp/screen.png'

  scrot -z "$tmpbg"
  convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
  i3lock -t -f -i "$tmpbg"
}
