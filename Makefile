ESCAPE = 'includes\|extends\|git\|hg\|components\|node_modules'

JADE 			= $(shell find -L -path "*templates/**.jade" | grep -v $(ESCAPE) )
TEMPLATES = $(JADE:.jade=.js)

JADE = $(shell find -L -name "*.jade" | grep -v $(ESCAPE) )
HTML = $(JADE:.jade=.html)

COFFEE 	= $(shell find -L -name "*.coffee" | grep -v $(ESCAPE) )
JS 			= $(COFFEE:.coffee=.js)

STYL 	= $(shell find -L -name "*.styl" | grep -v $(ESCAPE) )
CSS 	= $(STYL:.styl=.css)

build: $(HTML) $(CSS) $(JS) $(TEMPLATES)
	@component build --dev

%.css: %.styl
	stylus -u nib $<

%.html: %.jade
	jade -P < $< --path $< > $@

%.js: %.html
	component convert $<

%.js: %.coffee
	coffee -bc $<

clean:
	rm -rf $(HTML) $(CSS) $(JS) $(TEMPLATES)

.PHONY: clean