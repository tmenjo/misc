#!/bin/bash -x
export LANG=C LC_ALL=C
sudo apt-get --quiet -y install \
  build-essential pkg-config autoconf libtool yasm liburcu-dev libzookeeper-mt-dev
