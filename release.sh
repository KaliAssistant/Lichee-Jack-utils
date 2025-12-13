#!/usr/bin/env bash

ROOT="$(cd "$(dirname "$0")" && pwd)"
RELEASE_TITLE="$(git log -1 --date=format:%Y.%m --format='%cd-%h')"
OUT="$ROOT/out"
RELEASE_DIR="$ROOT/.release/$RELEASE_TITLE/lichee-jack-utils"

mkdir -p $RELEASE_DIR

cp -r $OUT/*.deb $RELEASE_DIR

cd ${RELEASE_DIR}/..
tar cJf lichee-jack-utils_${RELEASE_TITLE}_all.tar.xz lichee-jack-utils

cd $ROOT
