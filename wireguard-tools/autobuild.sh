#!/usr/bin/bash
set -e

. "$(dirname "$0")/../scripts/build-common.sh"

need_tools make pkgconf autoconf automake libtool riscv64-linux-gnu-gcc

rm -rf build pkg

ppwd=$(pwd)

echo "Build wireguard-tools..."

cd $ppwd/src

make CC=riscv64-linux-gnu-gcc WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes WITH_SYSTEMDUNITS=yes

make install STRIP=riscv64-linux-gnu-strip DESTDIR="$ppwd/build"

cd $ppwd

cp -r ./DEBIAN ./build
mkdir -p ./pkg
fakeroot dpkg-deb --build build ./pkg/wireguard-tools_0.0.1_licheejack_riscv64.deb

