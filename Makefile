help: Makefile
	@awk -F':.*?##' '/^[a-z0-9\\%!:-]+:.*##/{gsub("%","*",$$1);gsub("\\\\",":*",$$1);printf "\033[36m%8s\033[0m %s\n",$$1,$$2}' $<

ci: src deps clean ## Run CI scripts
	@npm run test -- --color $(E2E_FLAGS)
	@HASHCHANGE=true npm run test -- --color $(E2E_FLAGS)

dev: src deps ## Start dev tasks
	@npm run dev & npm run serve

e2e: src deps ## Run E2E tests locally
	@npm run test:e2e -- e2e/cases $(E2E_FLAGS)

deps: package*.json
	@(((ls node_modules | grep .) > /dev/null 2>&1) || npm i) || true

clean:
	@rm -rf dist/* e2e/public/assets
