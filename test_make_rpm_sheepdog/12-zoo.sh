#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

"${0%/*}"/01-setup.sh

sudo yum -y install zookeeper-native

./autogen.sh
./configure --disable-corosync --enable-zookeeper
make rpm

"${0%/*}"/02-install-rpm.sh

exit 0
