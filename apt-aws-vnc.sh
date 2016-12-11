#!/bin/bash
export LANG=C LC_ALL=C
set -x
sudo apt update
sudo apt -y install \
	ubuntu-desktop vnc4server gnome-panel gnome-settings-daemon \
	metacity nautilus gnome-terminal
