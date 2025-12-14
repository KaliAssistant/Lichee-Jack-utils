#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/out"
ARCH="${ARCH:-riscv64}"

mkdir -p "$OUT"

PROJECTS=(
  aic8800_fw
  gt
  jack-coreutils
  shmled
  wireguard-tools
  wgcf
  usque
)

for p in "${PROJECTS[@]}"; do
  echo
  echo "==== Building $p ===="
  pushd "$ROOT/$p" >/dev/null
    ./autobuild.sh
    find pkg -name "*.deb" -exec cp -v {} "$OUT/" \;
  popd >/dev/null
done

echo
echo "All packages built successfully"
echo "Output: $OUT"

