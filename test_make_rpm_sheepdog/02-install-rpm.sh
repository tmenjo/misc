#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

rpm=$(find x86_64 -type f -not -name '*-debuginfo-*')
rpm -qpli "${rpm}"

rpm -iv "${rpm}"
rpm -q sheepdog
rpm -e sheepdog
! rpm -q sheepdog
