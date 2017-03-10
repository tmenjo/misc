#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

REPO_ZK=http://www.apache.org/dist/bigtop/stable/repos/centos7/bigtop.repo

sudo yum -y groupinstall "Development Tools"

sudo yum -y install epel-release
sudo yum -y install yasm-devel userspace-rcu-devel

sudo curl -o /etc/yum.repos.d/"${REPO_ZK##*/}" "${REPO_ZK}"
