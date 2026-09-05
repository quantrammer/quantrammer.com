.PHONY: sync build serve check clean
sync:  ; scripts/sync-legal.sh
build: ; scripts/build.sh
serve: build ; cd docs && python3 -m http.server 8787
check: ; scripts/check-live.sh
clean: ; rm -rf docs
