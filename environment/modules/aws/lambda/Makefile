default: | help

build: ## build all functions
	@for f in `find functions -type d -maxdepth 1 -not -path functions`; do \
		echo "building" $$f && \
		(cd $$f && sh build.sh) \
	; done

help:  ## Show all of tasks
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: \
	default \
	build \
	help \
