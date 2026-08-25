#!/bin/zsh
set -euo pipefail
cd "$(dirname "$0")"
clang -O2 -Wall -Wno-deprecated-declarations -o inputassist inputassist.c \
  -framework IOKit -framework CoreFoundation -framework CoreGraphics
# Keep a private copy of the curve used at LaunchDaemon start.
if [[ -f pattern.txt && ! -f curve.dat ]]; then
  cp pattern.txt curve.dat
fi
echo "Built: $(pwd)/inputassist"
