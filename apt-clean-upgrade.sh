#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
sudo rm -rf /var/lib/apt/lists/*
sudo apt --quiet clean
sudo apt --quiet update ||:
sudo apt --quiet -y upgrade
