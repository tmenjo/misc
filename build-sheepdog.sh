#!/bin/bash
set -xueo pipefail
export LANG=C LC_ALL=C
(
  cd ~
  if [ ! -d sheepdog ] ; then
    git clone https://github.com/tmenjo/sheepdog.git
  fi
  cd sheepdog
  ./autogen.sh
  ./configure --prefix=/usr --localstatedir=/var \
    --enable-zookeeper --disable-corosync
  make
  sudo make install
)
