#!/usr/bin/bash
set -e

for tool in cmake make a2x pkgconf autoconf automake libtool riscv64-linux-gnu-gcc riscv64-linux-gnu-g++; do
    if ! command -v $tool >/dev/null 2>&1; then
        echo "Error: $tool not found. Please install it." >&2
        exit 1
    fi
done

rm -rf build lib/build src/build pkg

ppwd=$(pwd)

echo "Build libconfig..."
cd ./lib/libconfig-1.8.1
autoreconf -ifv
./configure --host=riscv64-linux-gnu --prefix=/usr --enable-static --disable-shared
make -j`nproc`
make install-strip DESTDIR="$ppwd/lib/build"

cd "$ppwd"

echo "Build libusbgx..."
cd ./lib/libusbgx-v0.3.0
autoreconf -ifv
export LDFLAGS="-L$ppwd/lib/build/usr/lib"
./configure --host=riscv64-linux-gnu --prefix=/usr --enable-static --disable-shared
make -j`nproc`
make install-strip DESTDIR="$ppwd/lib/build"

cd "$ppwd"

echo "Build gt..."
mkdir -p ./src/build && cd ./src/build
cmake .. \
  -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=riscv \
  -DCMAKE_C_COMPILER=riscv64-linux-gnu-gcc \
  -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++ \
  -DCMAKE_FIND_ROOT_PATH="$ppwd/lib/build/usr" \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
  -DCMAKE_INSTALL_PREFIX="$ppwd/build/usr" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_EXE_LINKER_FLAGS="-static" \
  -DGT_SETTING_PATH="/etc/gt/gt.conf"

make -j`nproc`
make install

cd "$ppwd"

riscv64-linux-gnu-strip ./build/usr/bin/gt
mkdir -p ./build/etc/gt
cp ./build/usr/etc/gt/gt.conf ./build/etc/gt
cp -r ./templates ./build/usr/etc/gt

cp -r ./DEBIAN ./build
mkdir -p ./pkg
dpkg-deb --build build ./pkg/gt_0.0.1_riscv64.deb
