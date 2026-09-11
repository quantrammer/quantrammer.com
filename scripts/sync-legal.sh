#!/usr/bin/env bash
# Copies the canonical legal docs from the PurposeNotes repo into content/,
# stripping the "Hosting note" blockquote (which is not part of the policy).
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${PURPOSENOTES_DIR:-$HERE/../../../PurposeNotes}/docs/legal"
[ -d "$SRC" ] || { echo "PurposeNotes docs/legal not found at $SRC (set PURPOSENOTES_DIR)"; exit 1; }
strip() { awk 'BEGIN{skip=0} /^> \*\*Hosting note/{skip=1} skip&&/^$/{skip=0;next} !skip{print}' "$1"; }

# Prepend presentation-only YAML frontmatter. This drives <meta description>,
# the page eyebrow, and the nav aria-current state in templates/page.html.
# The legal prose itself is copied verbatim from the source of truth.
front() {
  # Values are double-quoted: descriptions contain colons, which are
  # a YAML mapping indicator when bare.
  printf -- '---\ndescription: "%s"\neyebrow: "%s"\n%s: true\n---\n\n' "$1" "$2" "$3"
}

{ front "How PurposeNotes handles your data: no accounts, no servers of ours, no analytics." \
        "PurposeNotes · Legal" "nav-privacy"
  strip "$SRC/PRIVACY_POLICY.md"
} > "$HERE/content/purposenotes/privacy.md"

{ front "Help, FAQ, troubleshooting, and data export for PurposeNotes." \
        "PurposeNotes · Help" "nav-support"
  strip "$SRC/SUPPORT.md"
} > "$HERE/content/purposenotes/support.md"

echo "synced: privacy.md support.md"
