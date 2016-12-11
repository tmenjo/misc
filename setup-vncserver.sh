#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
bin="${0%/*}"

[ -n "$1" ] || exit 1

"$bin"/apt-aws-vnc.sh
"$bin"/vncdes.sh "$1"
vncserver :1
vncserver -kill :1
"$bin"/sed-xstartup.sh
vncserver -geometry 1600x900 -depth 24 :1
