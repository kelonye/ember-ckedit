default: node_modules components public/kelonye-ember-ckedit

node_modules:
	@npm install

components:
	@./node_modules/component-hooks/node_modules/.bin/component install --dev

# hack
public/kelonye-ember-ckedit: public
	@mkdir -p $@
	@ln -sf $(PWD)/component.json $@
	@ln -sf $(PWD)/index.js $@
	@ln -sf $(PWD)/ckeditor $@
	@ln -sf $(PWD)/lib $@

public:
	@./node_modules/component-hooks/node_modules/.bin/component build --dev -o $@ -n $@

find:
	@find ckeditor/plugins -type f && find ckeditor/skins -type f

example: default
	@node $@

clean:
	@rm -rf public

.PHONY: clean example find