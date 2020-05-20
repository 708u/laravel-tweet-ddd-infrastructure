.PHONY: tf
ifeq (tf,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
tf: ## Execute terraform commands with arguments.
	docker-compose run --rm terraform $(RUN_ARGS)

.PHONY: aws
ifeq (aws,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
aws: ## Execute terraform commands with arguments.
	docker-compose run --rm awscli $(RUN_ARGS)

.PHONY: plan
plan: ## Execute terraform plan.
	docker-compose run --rm terraform plan

.PHONY: apply
apply: ## Execute terraform apply.
	docker-compose run --rm terraform apply

.PHONY: destory
destroy: ## Execute terraform destroy.
	docker-compose run --rm terraform destroy

.PHONY: help
help: ## Display all make commands with help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: format
format: ## format .tf files
	docker-compose run --rm terraform fmt
