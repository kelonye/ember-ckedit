example:
	@$(MAKE) --no-print-directory -C example

find:
	@find ckeditor/plugins -type f && find ckeditor/skins -type f

.PHONY: find example
