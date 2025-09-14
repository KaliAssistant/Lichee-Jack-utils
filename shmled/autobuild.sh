#!/usr/bin/bash
set -e

for tool in cmake make a2x pkgconf autoconf automake libtool riscv64-linux-gnu-gcc riscv64-linux-gnu-g++; do
    if ! command -v $tool >/dev/null 2>&1; then
        echo "Error: $tool not found. Please install it." >&2
        exit 1
    fi
done

rm -rf build pkg

ppwd=$(pwd)

echo "Build shmled..."
./autogen.sh
./configure --host=riscv64-linux-gnu --prefix=/usr
make -j`nproc`
make install-strip DESTDIR="$ppwd/build"

cp -r ./DEBIAN ./build
mkdir -p ./pkg
dpkg-deb --build build ./pkg/shmled_0.0.1_licheejack_riscv64.deb
