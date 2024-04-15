import subprocess

from prefect import flow, task


@task(log_prints=True)
def run_dlt():
    # Execute the main.py inside the dlt_bigquery Docker container
    command = ["docker-compose", "run", "--rm", "dlt_bigquery"]
    subprocess.run(command, check=True)


@task(log_prints=True)
def run_dbt():
    # Execute dbt run inside the dbt Docker container
    command = ["docker-compose", "run", "--rm", "dbt"]
    subprocess.run(command, check=True)


@flow(log_prints=True)
def elt_flow():
    run_dlt()
    run_dbt()
