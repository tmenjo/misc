#!/bin/bash
set -x
export LANG=C LC_ALL=C
sudo apt-get --quiet -y install \
  git pkg-config make autoconf libtool yasm liburcu-dev libzookeeper-mt-dev
