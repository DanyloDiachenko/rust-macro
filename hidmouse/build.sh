#!/bin/zsh
set -euo pipefail
cd "$(dirname "$0")"
pkill -f 'hidmouse/hid_mouse_daemon' 2>/dev/null || true
clang -O2 -o hid_mouse_daemon hid_mouse_daemon.c \
  -framework IOKit -framework CoreFoundation
echo "Built: $(pwd)/hid_mouse_daemon"
echo "Uses IOHIDPostEvent → IOHIDSystem (relative, idle OK in raw-input games)."
echo "Run as your login user (not root). Accessibility may be required."
