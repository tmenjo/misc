#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

rpm -e sheepdog ||:

sudo yum -y remove \
	corosync fuse-libs \
	corosynclib-devel fuse-devel zookeeper-native
sudo yum -y autoremove

make maintainer-clean ||:
rm -rf x86_64/ sheepdog-*
