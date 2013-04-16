all: node_modules lib lib/index.js lib/style.css

node_modules:
	@npm install

lib:
	@mkdir -p lib

lib/index.js: src/index.coffee
	coffee -bcj $@ $<

lib/style.css: src/style.styl
	stylus -u nib --compress < $< > $@

find:
	@find ckeditor/plugins -type f && find ckeditor/skins -type f

clean:
	@rm -rf lib

example:
	@$(MAKE) -C example

.PHONY: clean find example