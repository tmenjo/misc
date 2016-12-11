#!/bin/bash
export LANG=C LC_ALL=C
umask 0022
set -xueo pipefail

src=vnc-4_1_3-unixsrc

curl -L -o /tmp/"${src}".tar.gz \
	https://archive.realvnc.com/download/binary/785/
tar -C /tmp -xvzf /tmp/"${src}".tar.gz

cat <<'EOF' >/tmp/vncdes.c
#include <stdio.h>
#include <string.h>
#include <common/rfb/d3des.h>

int main(int argc, char *argv[])
{
	static unsigned char key[8] = {23,82,107,6,35,78,88,7};
	static unsigned char text[8] = {0,0,0,0,0,0,0,0};

	if (argc < 2)
		return 1;

	const size_t len = strlen(argv[1]);
	if (len < 6)
		return 1;

	memcpy(text, argv[1], 8 < len ? 8 : len); /*min(8,len)*/
	deskey(key, EN0);
	des(text, text);
	fwrite(text, 1, 8, stdout);

	return 0;
}
EOF

gcc -I/tmp/"${src}" -o /tmp/vncdes \
	/tmp/vncdes.c /tmp/"${src}"/common/rfb/d3des.c

mkdir -p ~/.vnc
rm -f ~/.vnc/passwd
umask 0066
/tmp/vncdes "$1" >~/.vnc/passwd
