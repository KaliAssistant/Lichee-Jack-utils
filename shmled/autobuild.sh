#!/usr/bin/bash
set -e

. "$(dirname "$0")/../scripts/build-common.sh"

need_tools cmake make a2x pkgconf autoconf automake libtool riscv64-linux-gnu-gcc riscv64-linux-gnu-g++


rm -rf build pkg

ppwd=$(pwd)

echo "Build shmled..."
./autogen.sh
./configure --host=riscv64-linux-gnu --prefix=/usr
make -j`nproc`
make install-strip DESTDIR="$ppwd/build"

cp -r ./DEBIAN ./build
mkdir -p ./pkg
fakeroot dpkg-deb --build build ./pkg/shmled_0.0.1_licheejack_riscv64.deb
