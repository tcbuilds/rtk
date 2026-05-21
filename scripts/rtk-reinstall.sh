#!/usr/bin/env bash
# Rebuild rtk from source and install into ~/.local/bin, overwriting in place.
# Uses --root ~/.local so the binary does NOT land in ~/.cargo/bin (which is
# earlier on PATH and would shadow this copy). Run from anywhere.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="${RTK_REPO:-$(dirname "$SCRIPT_DIR")}"
ROOT="${RTK_INSTALL_ROOT:-$HOME/.local}"

if [ ! -f "$REPO/Cargo.toml" ]; then
  echo "rtk-reinstall: no Cargo.toml at $REPO (set RTK_REPO to override)" >&2
  exit 1
fi

echo "rtk-reinstall: building + installing from $REPO -> $ROOT/bin"
cargo install --path "$REPO" --root "$ROOT" --force

hash -r 2>/dev/null || true
echo "rtk-reinstall: installed $(command -v rtk)"
rtk --version
