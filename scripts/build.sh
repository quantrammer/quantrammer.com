#!/usr/bin/env bash
# content/**/name.md  -> docs/**/name/index.html   (clean URL: /purposenotes/privacy)
# content/**/index.md -> docs/**/index.html
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$HERE/docs"
command -v pandoc >/dev/null || { echo "pandoc missing: brew install pandoc"; exit 1; }
rm -rf "$OUT"; mkdir -p "$OUT"
cp -R "$HERE/static/." "$OUT/"
touch "$OUT/.nojekyll"
find "$HERE/content" -name '*.md' | while read -r md; do
  rel="${md#$HERE/content/}"; rel="${rel%.md}"
  if [ "$(basename "$rel")" = "index" ]; then dir="$OUT/$(dirname "$rel")"; else dir="$OUT/$rel"; fi
  [ "$dir" = "$OUT/." ] && dir="$OUT"
  mkdir -p "$dir"
  pandoc "$md" --standalone --from gfm --to html5 \
    --shift-heading-level-by=-1 \
    --template "$HERE/templates/page.html" \
    --metadata lang=en \
    --output "$dir/index.html"
  echo "built ${dir#$OUT}/index.html"
done
