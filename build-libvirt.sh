#!/bin/bash
set -xueo pipefail
export LANG=C LC_ALL=C
[ -n "$1" ] # eg) http://libvirt.org/sources/libvirt-1.2.17.tar.gz
file="${1##*/}" # eg) libvirt-1.2.17.tar.gz
dir="${file%.tar.gz}" # eg) libvirt-1.2.17
(
  cd ~
  if [ ! -d "$dir" ] ; then
    if [ ! -f "$file" ] ; then
      wget "$1" -O "$file"
    fi
    tar xzvf "$file"
  fi
  cd "$dir"
  ./autogen.sh --system
  make
  sudo make install
)
