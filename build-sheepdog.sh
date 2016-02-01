#!/bin/bash
set -xueo pipefail
export LANG=C LC_ALL=C
if [ ! -d ~/sheepdog ] ; then
  git clone "${SHEEPDOG_GITREPO:-https://github.com/sheepdog/sheepdog.git}"
fi
cd ~/sheepdog
git checkout "${SHEEPDOG_GITBRANCH:-master}"
./autogen.sh
./configure --prefix=/usr --localstatedir=/var \
  --enable-zookeeper --disable-corosync
make
sudo make install-exec

