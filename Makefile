.PHONY: help plan apply

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

plan:		## Run terraform plan
	terraform plan -out /tmp/plan.tfplan -refresh=false

apply:		## Run terraform apply
	terraform apply /tmp/plan.tfplan

refresh:		## Run terraform refresh
	terraform refresh
