.PHONY: updaterepo


updaterepo: SHELL:=/bin/bash
updaterepo: ## Remove build related file
	@helm repo index ./chart-repo
