.ONESHELL:
# Variables
VENV := myenv
PYTHON := python3
PIP := $(VENV)/bin/pip
PYTHON_VENV := $(VENV)/bin/activate
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

test:
	@echo $(ROOT_DIR)

.PHONY: help
help:  ## Show this helper
	@grep -h "##" $(MAKEFILE_LIST) | grep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# $(PIP) install -r requirements.txt
.PHONY: create
create: ## Create virtual environment
	$(PYTHON) -m venv $(VENV)
	chmod +x $(PYTHON_VENV)

.PHONY: install
install: ## Install dependencies
	. $(PYTHON_VENV) && $(PIP) install -r requirements.txt

.PHONY: activate
activate:
	. $(PYTHON_VENV)
	@echo "run if you wantsource $(PYTHON_VENV)""
	

.PHONY: clean
clean: ## Clean virtual environment
	rm -rf $(VENV)
	rm -rf __pycache__
	rm -rf data/*

.PHONY: run
run: create install## Run the application
	. $(PYTHON_VENV) && $(PYTHON) create_bronze.py
	. $(PYTHON_VENV) && dbt run --profiles-dir "$(ROOT_DIR)/fire_dbt_project" --project-dir "$(ROOT_DIR)/fire_dbt_project"
