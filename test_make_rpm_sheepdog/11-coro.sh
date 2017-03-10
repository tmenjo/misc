#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

"${0%/*}"/01-setup.sh

sudo yum -y install corosynclib-devel

./autogen.sh
./configure
make rpm

sudo yum -y remove corosynclib-devel
sudo yum -y autoremove
sudo yum -y install corosync

"${0%/*}"/02-install-rpm.sh

exit 0
