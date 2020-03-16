#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
session=${1:-xmonad}

[ -f "$usermodmap" ] && xmodmap "$usermodmap"
[ -f "$userresources" ] xrdb -merge "$userresources"
