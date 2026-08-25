#!/bin/zsh
# Installs LaunchDaemons:
#   org.pqrs.karabiner-vhid-daemon  - VirtualHID service
#   com.local.inputassist          - local input helper (needs root socket)
set -eu

HERE="$(cd "$(dirname "$0")" && pwd)"

# Remove previous label if present
for old in com.rifle.hidmouse com.local.inputassist; do
  launchctl bootout system/$old 2>/dev/null || true
  rm -f "/Library/LaunchDaemons/$old.plist"
done

for label in org.pqrs.karabiner-vhid-daemon com.local.inputassist; do
  launchctl bootout system/$label 2>/dev/null || true
  cp "$HERE/$label.plist" "/Library/LaunchDaemons/$label.plist"
  chown root:wheel "/Library/LaunchDaemons/$label.plist"
  chmod 644 "/Library/LaunchDaemons/$label.plist"
done

# Prefer the curve.dat used by the helper
if [[ -f "$HERE/pattern.txt" ]]; then
  cp "$HERE/pattern.txt" "$HERE/curve.dat"
fi

launchctl bootstrap system /Library/LaunchDaemons/org.pqrs.karabiner-vhid-daemon.plist
sleep 2
launchctl bootstrap system /Library/LaunchDaemons/com.local.inputassist.plist

echo "installed"
