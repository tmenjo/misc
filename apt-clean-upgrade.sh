#!/bin/bash
set -x
export LANG=C LC_ALL=C
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get --quiet clean
sudo apt-get --quiet update ||: # ignore error
sudo apt-get --quiet -y upgrade
