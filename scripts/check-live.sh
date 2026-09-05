#!/usr/bin/env bash
# Post-deploy acceptance checks. Exit non-zero on any failure.
set -u
BASE="${1:-https://quantrammer.com}"
fail=0
chk(){ local want="$1" url="$2"; local got; got=$(curl -s -o /dev/null -w '%{http_code}' -m 15 -L "$url"); if [ "$got" = "$want" ]; then echo "ok   $got $url"; else echo "FAIL $got (want $want) $url"; fail=1; fi; }
chk 200 "$BASE/"
chk 200 "$BASE/purposenotes/"
chk 200 "$BASE/purposenotes/privacy"
chk 200 "$BASE/purposenotes/privacy/"
chk 200 "$BASE/purposenotes/support"
chk 200 "$BASE/purposenotes/support/"
chk 200 "$BASE/style.css"
chk 404 "$BASE/does-not-exist"
# http -> https
code=$(curl -s -o /dev/null -w '%{http_code}' -m 15 "http://${BASE#https://}/purposenotes/privacy"); case "$code" in 301|308) echo "ok   $code http->https redirect";; *) echo "FAIL $code http->https redirect"; fail=1;; esac
# www -> apex
code=$(curl -s -o /dev/null -w '%{http_code} %{redirect_url}' -m 15 "https://www.${BASE#https://}/"); echo "info www: $code"
# content sanity
curl -sL -m 15 "$BASE/purposenotes/privacy/" | grep -q "Last updated" && echo "ok   privacy has 'Last updated'" || { echo "FAIL privacy missing 'Last updated'"; fail=1; }
curl -sL -m 15 "$BASE/purposenotes/privacy/" | grep -q "Hosting note" && { echo "FAIL hosting note leaked into page"; fail=1; } || echo "ok   hosting note stripped"
curl -sL -m 15 "$BASE/purposenotes/support/" | grep -q "support@quantrammer.com" && echo "ok   support email present" || { echo "FAIL support email missing"; fail=1; }
# no third-party requests
curl -sL -m 15 "$BASE/purposenotes/privacy/" | grep -Eo 'https?://[^"'"'"' )]+' | grep -v quantrammer.com | grep -v -E 'apple.com|huggingface.co|sitemaps.org' && { echo "WARN external URLs above (expected: only in-text links)"; } || echo "ok   no unexpected external resources"
# email
mx=$(dig +short MX "${BASE#https://}"); [ -n "$mx" ] && echo "ok   MX: $mx" || { echo "FAIL no MX record: privacy@/support@ will bounce"; fail=1; }
exit $fail
