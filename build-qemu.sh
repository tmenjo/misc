#!/bin/bash
set -xueo pipefail
export LANG=C LC_ALL=C
(
  cd ~
  if [ ! -d qemu ] ; then
    git clone "${QEMU_GITREPO:-git://git.qemu-project.org/qemu.git}"
  fi
  cd qemu
  git checkout "${QEMU_GITBRANCH:-master}"
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
    --target-list=x86_64-softmmu
  make
  sudo make install
)
