.PHONY: help setup_uv install_dependencies create_venv activate_venv run_prefect_server deploy_prefect run_docker delete_docker start_evidence dev_evidence

help:
	@echo "Usage:"
	@echo "  make setup_uv                    - Instructions of uv using a script, system package manager, or pipx"
	@echo "  make install_dependencies        - Installs python dependencies using uv"
	@echo "  make create_venv                 - Creates a virtual environment using uv"
	@echo "  make activate_venv               - Instructions to activate python virtual environment"
	@echo "  make run_prefect_server          - Runs prefect localhost server"
	@echo "  make deploy_prefect              - Deploys Prefect flows"
	@echo "  make start_evidence              - Sets up and runs the evidence.dev project"

setup_uv:
	@echo "Run: curl -LsSf https://astral.sh/uv/install.sh | sh on macOs/Linux, or powershell -c 'irm https://astral.sh/uv/install.ps1 | iex' on Windows, or pipx install uv using Python"

install_dependencies: create_venv
	@uv pip install -r requirements.txt

create_venv:
	@uv venv

activate_venv:
	@echo "Run 'source .venv/bin/activate' on macOS/Linux or '.venv\\Scripts\\activate' on Windows to activate the virtual environment."

run_prefect_server:
	@prefect server start

deploy_prefect:
	@prefect deploy -n elt_prefect

start_evidence:
	@cd evidence_bigquery && npm install && npm run sources && npm run dev
