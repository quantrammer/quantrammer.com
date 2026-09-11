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
  # Title comes from the first `# ` heading, passed as metadata so the
  # <title> tag is right WITHOUT --shift-heading-level-by=-1 (which would
  # promote every `##` section to a second <h1>). The body keeps its own
  # single h1; `##` stay h2.
  # Strip inline HTML (the display <em> accent) so <title> stays plain text.
  title="$(sed -n 's/^# //p' "$md" | head -1 | sed 's/<[^>]*>//g')"
  pandoc "$md" --standalone --from gfm --to html5 \
    --template "$HERE/templates/page.html" \
    --metadata lang=en \
    --metadata title="$title" \
    --output "$dir/index.html"
  echo "built ${dir#$OUT}/index.html"
done
