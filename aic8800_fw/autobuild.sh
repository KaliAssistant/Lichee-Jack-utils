#!/usr/bin/bash
set -e

. "$(dirname "$0")/../scripts/build-common.sh"

rm -rf build pkg

ppwd=$(pwd)

echo "Build aic8800-firmware..."
mkdir -p ./build/usr/lib
mkdir -p ./build/etc
cp -r ./DEBIAN ./build
cp -r ./firmware ./build/usr/lib
cp -r ./modprobe.d ./build/etc
mkdir -p ./pkg

fakeroot dpkg-deb --build build ./pkg/aic8800-firmware_0.0.1_licheejack_riscv64.deb
