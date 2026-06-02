#!/usr/bin/env bash
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# avatar
cp "$REPO/assets/face.icon" ~/.face.icon

# wallpapers
mkdir -p ~/Pictures/Wallpapers
cp "$REPO/assets/wallpapers/*" ~/Pictures/Wallpapers/
