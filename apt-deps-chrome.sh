#!/bin/bash
set -x
export LANG=C LC_ALL=C
sudo apt-get --quiet -y install \
  libgconf2-4 libnss3-1d libxss1 libappindicator1 libindicator7
