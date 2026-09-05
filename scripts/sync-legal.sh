#!/usr/bin/env bash
# Copies the canonical legal docs from the PurposeNotes repo into content/,
# stripping the "Hosting note" blockquote (which is not part of the policy).
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${PURPOSENOTES_DIR:-$HERE/../../../PurposeNotes}/docs/legal"
[ -d "$SRC" ] || { echo "PurposeNotes docs/legal not found at $SRC (set PURPOSENOTES_DIR)"; exit 1; }
strip() { awk 'BEGIN{skip=0} /^> \*\*Hosting note/{skip=1} skip&&/^$/{skip=0;next} !skip{print}' "$1"; }
strip "$SRC/PRIVACY_POLICY.md" > "$HERE/content/purposenotes/privacy.md"
strip "$SRC/SUPPORT.md"        > "$HERE/content/purposenotes/support.md"
echo "synced: privacy.md support.md"
