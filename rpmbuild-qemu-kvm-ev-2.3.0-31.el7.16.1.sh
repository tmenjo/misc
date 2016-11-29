#!/bin/bash -x
set -ue
export LANG=C LC_ALL=C

srcrpm=http://resources.ovirt.org/pub/ovirt-4.0/rpm/el7/SRPMS/qemu-kvm-ev-2.3.0-31.el7.16.1.src.rpm
curl -o ~/"${srcrpm##*/}" "${srcrpm}"
rpm -i ~/"${srcrpm##*/}"

patch0001=https://raw.githubusercontent.com/yamada-h/qemu-kvm-rhev-2.3.0-rpmbuild/master/SOURCES/0001-sheepdog-fix-resource-leak-with-sd_snapshot_create.patch
patch0002=https://raw.githubusercontent.com/yamada-h/qemu-kvm-rhev-2.3.0-rpmbuild/master/SOURCES/0002-sheepdog-serialize-requests-to-overwrapping-area.patch
patch0003=https://raw.githubusercontent.com/yamada-h/qemu-kvm-rhev-2.3.0-rpmbuild/master/SOURCES/0003-sheepdog-use-per-AIOCB-dirty-indexes-for-non-overlap.patch
patch0004=https://raw.githubusercontent.com/yamada-h/qemu-kvm-rhev-2.3.0-rpmbuild/master/SOURCES/0004-sheepdog-refine-discard-support.patch
curl -o ~/rpmbuild/SOURCES/"${patch0001##*/}" "${patch0001}"
curl -o ~/rpmbuild/SOURCES/"${patch0002##*/}" "${patch0002}"
curl -o ~/rpmbuild/SOURCES/"${patch0003##*/}" "${patch0003}"
curl -o ~/rpmbuild/SOURCES/"${patch0004##*/}" "${patch0004}"

# I know the number of contained patches is 587 :)
sed -i.bak \
-e 's/^Release: 31%{?dist}.16.1$/Release: 31%{?dist}.16.1_sd/' \
-e '/^Patch587:/a \
# For Sheepdog\
Patch588: '"${patch0001##*/}"'\
Patch589: '"${patch0002##*/}"'\
Patch590: '"${patch0003##*/}"'\
Patch591: '"${patch0004##*/}" \
-e '/^%patch587/a \
%patch588 -p1\
%patch589 -p1\
%patch590 -p1\
%patch591 -p1' \
~/rpmbuild/SPECS/qemu-kvm.spec

sed -i.bak 's/--block-drv-rw-whitelist=/&sheepdog,/' ~/rpmbuild/SOURCES/build_configure.sh

yum -y groupinstall 'Development tools'
yum -y install \
	zlib-devel SDL-devel texi2html gnutls-devel cyrus-sasl-devel \
	libaio-devel pciutils-devel pulseaudio-libs-devel libiscsi-devel \
	ncurses-devel libattr-devel libusbx-devel usbredir-devel texinfo \
	spice-protocol spice-server-devel libseccomp-devel libcurl-devel \
	libssh2-devel librados2-devel librbd1-devel glusterfs-api-devel \
	glusterfs-devel systemtap-sdt-devel nss-devel libjpeg-devel \
	libpng-devel libuuid-devel bluez-libs-devel brlapi-devel \
	check-devel libcap-devel pixman-devel librdmacm-devel \
	gperftools-devel iasl lzo-devel snappy-devel numactl-devel

rpmbuild -ba ~/rpmbuild/SPECS/qemu-kvm.spec
