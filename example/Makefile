run: node_modules components
	@node server.js

node_modules:
	@npm i --dev

components:
	@./node_modules/component-hooks/node_modules/.bin/component install --dev

.PHONY: run
