#!/usr/bin/env bash
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# SDDM config
sudo cp "$REPO/etc/sddm.conf" /etc/sddm.conf

# SDDM theme
sudo cp -r "$REPO/usr/share/sddm/themes/silent" /usr/share/sddm/themes/

echo "SDDM config and theme deployed. Theme 'silent' is set in sddm.conf."
