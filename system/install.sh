#!/usr/bin/env bash
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME=/usr/share/sddm/themes/silent
TARGET_USER="${SUDO_USER:-$USER}"

echo "Ensure sddm-silent-theme is installed before running this script. (paru -S sddm-silent-theme)"

# SDDM main config
sudo cp "$REPO/etc/sddm.conf" /etc/sddm.conf

# silent theme customizations (theme itself from sddm-silent-theme AUR pkg)
sudo cp "$REPO/usr/share/sddm/themes/silent/configs/custom.conf" "$THEME/configs/"
sudo cp "$REPO/usr/share/sddm/themes/silent/metadata.desktop" "$THEME/"
sudo cp "$REPO/usr/share/sddm/themes/silent/backgrounds/marble.jpg" "$THEME/backgrounds/"
sudo install -Dm644 "$REPO/assets/face.icon" "/usr/share/sddm/faces/${TARGET_USER}.face.icon"

echo "SDDM config + silent customizations deployed."
