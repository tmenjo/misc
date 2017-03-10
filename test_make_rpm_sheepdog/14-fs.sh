#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

"${0%/*}"/01-setup.sh

sudo yum -y install fuse-devel

./autogen.sh
./configure --disable-corosync --enable-sheepfs
make rpm

sudo yum -y remove fuse-devel
sudo yum -y autoremove
sudo yum -y install fuse-libs

"${0%/*}"/02-install-rpm.sh

exit 0
