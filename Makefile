HUGO_VERSION := v0.68.3
IMAGE_NAME := dsegurag/hugo

themes/even/README.md:
	git submodule update --init --recursive

PHONY += server
server: themes/even/README.md
	docker run --rm -it \
	-v $(shell pwd):/site \
	-p 0.0.0.0:1313:1313/tcp \
	$(IMAGE_NAME):$(HUGO_VERSION) server --i18n-warnings --gc --disableFastRender --bind 0.0.0.0 $(RUN_ARGS)

PHONY += build
build: themes/even/README.md
	docker run --rm -it \
	-v $(shell pwd):/site \
	$(IMAGE_NAME):$(HUGO_VERSION) --gc --minify $(RUN_ARGS)

.PHONY: $(PHONY)
.DEFAULT_GOAL := server
