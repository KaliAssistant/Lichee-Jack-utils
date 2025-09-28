#!/usr/bin/bash
set -e

rm -rf build pkg

ppwd=$(pwd)

echo "Build jack-coreutils..."
mkdir -p ./build/usr/bin
mkdir -p ./build/usr/lib/systemd/system
mkdir -p ./build/root/config
cp -r ./DEBIAN ./build
cp src/scripts/* ./build/usr/bin
cp src/systemd/jack-coreutils.service ./build/usr/lib/systemd/system
chmod +x ./build/usr/bin/*
mkdir -p ./pkg

dpkg-deb --build build ./pkg/jack-coreutils_0.0.1_licheejack_riscv64.deb
