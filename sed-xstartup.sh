#!/bin/bash
export LANG=C LC_ALL=C

vars='\
export XKL_XMODMAP_DISABLE=1\
unset SESSION_MANAGER\
unset DBUS_SESSION_BUS_ADDRESS'

commands='\
gnome-session &\
gnome-panel &\
gnome-settings-daemon &\
metacity &\
nautilus &\
gnome-terminal &'

sed -i.bak \
	-e '/^# exec \/etc\/X11\/xinit\/xinitrc/a '"$vars" \
	-e 's/^x-terminal-emulator/#&/' \
	-e 's/^x-window-manager/#&/' \
	-e '$ a '"$commands" \
	~/.vnc/xstartup
