JADE = $(shell find test -name "*.jade")
HTML = $(JADE:.jade=.html)

COFFEE = $(shell find test lib -name "*.coffee") index.coffee
JS = $(COFFEE:.coffee=.js)

STYL 	= $(shell find lib -name "*.styl")
CSS 	= $(STYL:.styl=.css)

# test: build
# 	@mocha-phantomjs -R dot test/support/index.html

build: $(HTML) $(JS) $(CSS)
	@component build --dev

%.html: %.jade
	jade < $< --path $< > $@

%.css: %.styl
	stylus -u nib $<

%.js: %.coffee
	coffee -bc $<

clean:
	rm -rf $(HTML) $(JS) $(CSS) build

.PHONY: clean test