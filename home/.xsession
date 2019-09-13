#!/bin/sh

resources=$HOME/.Xresources

if [ -f "$resources" ]; then
	/usr/X11R6/bin/xrdb -merge "$resources"
fi

/usr/local/bin/awesome
