all: node_modules components build/kelonye-ember-ckedit

node_modules:
	@npm install

components:
	@component install --dev

# hack
build/kelonye-ember-ckedit: build
	@mkdir -p $@
	@ln -sf $(PWD)/component.json $@
	@ln -sf $(PWD)/index.js $@
	@ln -sf $(PWD)/ckeditor $@
	@ln -sf $(PWD)/lib $@

build: lib lib/index.js lib/style.css
	@component build --dev

lib:
	@mkdir -p lib

lib/index.js: src/index.coffee
	coffee -bcj $@ $<

lib/style.css: src/style.styl
	stylus -u nib --compress < $< > $@

find:
	@find ckeditor/plugins -type f && find ckeditor/skins -type f

example: all
	@coffee $@

clean:
	@rm -rf lib build

.PHONY: clean example find