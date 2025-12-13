#!/usr/bin/env bash
set -e

need_tools() {
  for t in "$@"; do
    command -v "$t" >/dev/null 2>&1 || {
      echo "Error: missing tool: $t" >&2
      exit 1
    }
  done
}

clean_dirs() {
  rm -rf build pkg
}

export MAKEFLAGS="-j$(nproc)"

