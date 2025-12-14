#!/usr/bin/bash

set -e

. "$(dirname "$0")/../scripts/build-common.sh"

need_tools go

rm -rf build pkg

ppwd=$(pwd)

echo "Build wgcf..."

CGO_ENABLED=0 GOARCH=riscv64 go build -ldflags="-s -w" -trimpath -x .

install -v -d ./build/usr/bin && install -v -m 0755 wgcf ./build/usr/bin/wgcf

cp -r ./DEBIAN ./build
mkdir -p ./pkg
fakeroot dpkg-deb --build build ./pkg/wgcf_0.0.1_licheejack_riscv64.deb

