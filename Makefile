COFFEE = $(shell find lib -name "*.coffee") index.coffee
JS 		 = $(COFFEE:.coffee=.js)

STYL 	= $(shell find lib -name "*.styl")
CSS 	= $(STYL:.styl=.css)

build: $(CSS) $(JS)

%.css: %.styl
	stylus -u nib $<

%.js: %.coffee
	coffee -bc $<

clean:
	rm -rf $(CSS) $(JS)

.PHONY: clean