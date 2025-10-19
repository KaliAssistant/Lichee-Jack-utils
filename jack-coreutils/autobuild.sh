#!/usr/bin/bash
set -e

rm -rf build pkg

ppwd=$(pwd)

echo "Build jack-coreutils..."
mkdir -p ./build/usr/bin
mkdir -p ./build/usr/lib/systemd/system
mkdir -p ./build/etc/gt/templates
mkdir -p ./build/etc/NetworkManager/system-connections
mkdir -p ./build/etc/update-motd.d
mkdir -p ./build/root/config/udhcpd
cp -r ./DEBIAN ./build
cp src/scripts/* ./build/usr/bin
cp src/systemd/*.service ./build/usr/lib/systemd/system
cp src/config/udhcpd/*.conf ./build/root/config/udhcpd
cp src/etc/gt/templates/*.scheme ./build/etc/gt/templates
cp src/etc/NetworkManager/system-connections/*.nmconnection ./build/etc/NetworkManager/system-connections
cp src/etc/update-motd.d/* ./build/etc/update-motd.d

chmod +x ./build/usr/bin/*
chmod +x ./build/etc/update-motd.d/*
chmod 600 ./build/etc/NetworkManager/system-connections/*.nmconnection
mkdir -p ./pkg

dpkg-deb --build build ./pkg/jack-coreutils_0.0.1_licheejack_riscv64.deb
