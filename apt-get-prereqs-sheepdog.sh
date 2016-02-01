#!/bin/bash
set -x
export LANG=C LC_ALL=C
sudo apt-get --quiet -y install \
  git autoconf libtool yasm liburcu-dev libzookeeper-mt-dev
