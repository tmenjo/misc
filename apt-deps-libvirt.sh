#!/bin/bash -x
export LANG=C LC_ALL=C
sudo apt-get --quiet -y install \
  autopoint libxml-xpath-perl libxml2-utils xsltproc libyajl-dev libxml2-dev \
  libdevmapper-dev libpciaccess-dev libnl-dev
