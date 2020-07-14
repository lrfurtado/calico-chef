MAKEFILE_LIST:=Makefile
.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# https://github.com/devopsgroup-io/vagrant-hostmanager
# https://github.com/dotless-de/vagrant-vbguest 
vagrant-plugins: ## Install common vagrant plugins
	vagrant plugin install vagrant-vbguest
	vagrant plugin install vagrant-hostmanager
