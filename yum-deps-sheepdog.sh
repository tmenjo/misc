#!/bin/bash -x
export LANG=C LC_ALL=C
set -ueo pipefail

YUM=(sudo yum -y)
REPO_ZK=http://www.apache.org/dist/bigtop/stable/repos/centos7/bigtop.repo

"${YUM[@]}" groupinstall "Development Tools"

"${YUM[@]}" install epel-release
"${YUM[@]}" install yasm-devel userspace-rcu-devel

sudo curl -o /etc/yum.repos.d/"${REPO_ZK##*/}" "${REPO_ZK}"
"${YUM[@]}" install zookeeper-native
