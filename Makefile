.PHONY: help
.DEFAULT_GOAL := help
# Variables
# Set IaC-Core to true to fetch if not exists locally
IaC-Core := true
DevOps-Venv := true
Pre-Commit := true
MAKEFILE = $(shell echo "$(MAKEFILE_LIST)" | awk '{ print $$1 }')
blog-howto := https://simonwillison.net/2020/Apr/20/self-rewriting-readme/
github-repo := https://github.com/williln/til
docker-repo-list := /etc/apt/sources.list.d/docker.list
til-repos := ("https://github.com/jbranchaud/til" "https://github.com/williln/til" "https://github.com/simonw/til" "https://github.com/jbranchaud/til" "https://github.com/thoughtbot/til" "https://github.com/jwworth/til")
EXCLUDE := -I '.git|.venv'
PLATFORM := -P ubuntu-latest=catthehacker/ubuntu:act-latest

til-readme: ## Read TIL repos README.md in array til-repos
	@(declare -a TIL=$(til-repos); for til in "$${TIL[@]}"; do glow -p $${til}; done)

blog-howto: ## Medium - Transform Your Favorite Python IDE Into a DevOps Tool
	@google-chrome --incognito $(blog-howto) &

install-act: ## Install act utility - Run action locallly
	@curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

tree: ## List folder structure
	@tree -a $(EXCLUDE) || true

list-action: ## List action
ifeq (, $(shell which act))
	@echo "No act installed in $(PATH), installing it...."
	@curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash && act -l
else
	@act -l
endif

dry-run-action: ## Dry-run action
	@act -n

run-action: ## Run action in verbose with platform $(PLATFORM) when defined
	@act -v

include Makefile-IaC-core
Makefile-IaC-core:
ifeq ("$(IaC-Core)","true")
	@curl \
                -o Makefile.fetched \
                -sL "https://raw.githubusercontent.com/JackySo-MYOB/IaC-core/main/Makefile-IaC-core"
	@echo "b68dfde5b8756bd40fa31acd8799921b277fb00880b4dca938c63e98401e4999 *Makefile.fetched" \
                | sha256sum --quiet --check - \
                && mv Makefile.fetched $@
endif

include Makefile-devops-venv
Makefile-devops-venv:
ifeq ("$(DevOps-Venv)","true")
ifeq ("$(Pre-Commit)","true")
	@curl \
                -o Makefile.fetched \
                -sL "https://raw.githubusercontent.com/JackySo-MYOB/IaC-core/main/Makefile-devops-venv"
	@echo "9e91e11a74eece877ccd18cf52f7270fb2f1deedb5d413219013106a18eb5662 *Makefile.fetched" \
                | sha256sum --quiet --check - \
                && mv Makefile.fetched $@
	@$(MAKE) -f $@ pre-commit
else
	@curl \
                -o Makefile.fetched \
                -sL "https://raw.githubusercontent.com/JackySo-MYOB/IaC-core/main/Makefile-devops-venv"
	@echo "9e91e11a74eece877ccd18cf52f7270fb2f1deedb5d413219013106a18eb5662 *Makefile.fetched" \
                | sha256sum --quiet --check - \
                && mv Makefile.fetched $@
endif
endif

