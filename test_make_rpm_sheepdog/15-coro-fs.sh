#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

"${0%/*}"/01-setup.sh

sudo yum -y install corosynclib-devel fuse-devel

./autogen.sh
./configure --enable-sheepfs
make rpm

sudo yum -y remove corosynclib-devel fuse-devel
sudo yum -y autoremove
sudo yum -y install corosync fuse-libs

"${0%/*}"/02-install-rpm.sh

exit 0
