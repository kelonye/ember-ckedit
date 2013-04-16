PWD=$(shell pwd)

start: node_modules components components/kelonye-ember-ckedit build
	@coffee .

node_modules:
	@npm install

components:
	@component install

components/kelonye-ember-ckedit:
	@mkdir -p $@
	@ln -sf $(PWD)/../component.json $@
	@ln -sf $(PWD)/../index.js $@
	@ln -sf $(PWD)/../ckeditor $@
	@ln -sf $(PWD)/../lib $@

build:
	@component build --dev

clean:
	@rm -rf build

.PHONY: start build