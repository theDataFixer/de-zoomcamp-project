# ELT themoviedb.org | Leveraging TMDB API

---

_This product uses the TMDB API but is not endorsed or certified by TMDB._

This project leverages The Movie Database (TMDB) API to extract and load data into Google BigQuery, transforms the data using dbt, and visualizes insights using Evidence. The goal is to provide key points of movie & tv series trends that helps media professionals and enthusiasts understand what content captures viewers' interest.

## Project overview

This pipeline is designed to streamline the process of data extraction, loading, transformation, and reporting. It uses modern data engineering tools and practices to ensure scalability and reproducibility.

## Architecture
<p align="center">
    <img src="images/data_architecture.png">
</p>

## BI
<p align="center">
    <img src="images/bi_as_code.png">
</p>

## Technologies used
- **dlt (Data Load Tool)**: For extracting and loading data into Google Bigquery.
- **dbt (Data Build Tool)**: For transforming data within BigQuery.
- **Evidence.dev**: Code-driven alternative to drag-and-drop BI tools.
- **Docker**: For containerization of the pipeline.
- **Prefect**: For workflow orchestration.
- **Terraform**: For Infrastucture as Code (IaC). 
- **Google BigQuery**: The Data Warehouse.
- **DuckDB**: For local testing.

## Only BigQuery? Why not Google Cloud Storage (GCS)?

I know using GCS is part of the evaluation criteria, however, I intentionally did not include it in this project for the following reasons:

1. **Data Volume**: The data volume from TMDb API is manageable within BigQuery without the need for intermediate storage.
2. **Complexity and Cost**: Avoiding GCS simplifies the architecture and reduces costs associated with storage and data transfer, especially beneficial for small to medium datasets.
3. **Direct Integration**: BigQuery directly integrates with external APIs like TMDb, enabling streamlined data ingestion and processing without the need for an additional storage layer.
4. **Misconceptions about "Data Lake"**: New data engineers often believe that integrating cloud storage like Google Coud Storage (GCS) or AWS S3 is a mandatory step in data pipelines. However, this is not always necessary and can sometimes introduce unneccesary complexity and costs. In scenarios where data can be directly ingested and processed by data warehousing solutions like BigQuery, bypassing intermediate cloud storage can streamline workflows and reduce overhead.

## Getting Started

### Prerequisites

- **[Docker installed](https://docs.docker.com/engine/install/)**
- **[Python installed](https://www.python.org/downloads/)**
- **[Terraform installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)**
- **Make**: While `make` is readily available and commonly used on Linux and macOs, it is not included by default in windows. Using [Chocolately](https://chocolatey.org/) (a package manager for windows) can be easily installed: `choco install make` 
- **[Node.js installed](https://nodejs.org/en/download/)**: This is to run [Evidence.dev, "Build Polished data products with SQL"](https://evidence.dev/)
- **[dlt credentials](https://dlthub.com/docs/walkthroughs/add_credentials)**: Click [here](https://dlthub.com/docs/walkthroughs/add_credentials) for instructions how to add credentials under .dlt/secrets.toml.
- **[evicence.dev credentials](https://docs.evidence.dev/core-concepts/data-sources/)**: Click [here](https://docs.evidence.dev/core-concepts/data-sources/) to connect your local development environment to BigQuery.
- **[Create Google Cloud Project](https://developers.google.com/workspace/guides/create-project)**
- **[Google Cloud Platform Credentials JSON](https://www.youtube.com/watch?v=rWcLDax-VmM)**
- **[DuckDB](https://duckdb.org/#quickinstall)**: This is completely optional, but in case you want to test your dlt python script locally, install DuckDB. 
- **[Generate API Key from TMDB themoviedb.org](https://developer.themoviedb.org/docs/getting-started)**


### Set up environment variables

Be sure to create `.env` file, and ensure is configured correctly for your dbt `profiles.yml` 

### Configurations

* **dbt Configuration**: Ensure `~/.dbt/profiles.yml` is correctly set up to connect to your BigQuery instance.
* **dlt Configuration**: Update `secrets.toml` under `.dlt/` with your keys from themoviedb.org and Google BigQuery .
* **prefect Configuration**: Ensure to change in prefect.yaml your `prefect.deployments.steps.set_working_directory`

### Terraform

I want to clarify the purpose and setup of Terraform within this project. The configuration files located in the terraform folder primarly ensure that the enviroment is correclty prepared, especially regarding the credentials file. Technically it is to be sure your keys are correct. That's it.

Fortunately `dlt` handles the creation of the necessary datasets, and given the simplicity of this project, using Terraform isn't essential, but it helps in ensuring that all system components are properly configured before running the pipeline.

If you decide to test, then you must update `variable "credentials_file"` default path. (go to terraform/variables.tf)

```bash
# Move to terraform folder
cd terraform/

# init project
terraform init

# plan
terraform plan

# apply
terraform apply
```

### Use of Makefile

You can refer to the `help` command for guidance on what commands are available and what each command does:


```bash
make help
```

Output:
```bash
Usage:
  make setup_uv                    - Instructions of uv using a script, system package manager, or pipx
  make install_dependencies        - Installs python dependencies using uv
  make create_venv                 - Creates a virtual environment using uv
  make activate_venv               - Instructions to activate python virtual environment
  make run_prefect_server          - Runs prefect localhost server
  make deploy_prefect              - Deploys Prefect flows
  make start_evidence              - Sets up and runs the evidence.dev project
```

This command will display all available options and their descriptions, allowing you to easily understand how to interact with your project using the make commands.


### Installation 

1. **Clone the repository and use Terraform**:
```bash
git clone git@github.com:theDataFixer/de-zoomcamp-project.git
cd de-zoomcamp-project
```

2. Install uv (An extremely fast Python package installer and resolver, written in Rust), and activate the virtual environment

```bash
make setup_uv
```

```bash
make create_venv
```

```bash
make activate_venv
```

3. Install python dependencies
```bash
make install_dependencies
```

### Usage

* Start Prefect Server:
```bash
make run_prefect_server
```

* Deploy Prefect Flows:
```bash
make deploy_prefect
```

* Start and use Evidence.dev:
```bash
make start_evidence
```

#### NOTE:
In case you get error in Prefect `sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) database is locked` then you should change your database to postgresql. Instructions [here](https://docs.prefect.io/latest/guides/host/#prefect-database)

In short, run:
`docker run -d --name prefect-postgres -v prefectdb:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=yourTopSecretPassword -e POSTGRES_DB=prefect postgres:latest`

And then:
`prefect config set PREFECT_API_DATABASE_CONNECTION_URL="postgresql+asyncpg://postgres:yourTopSecretPassword@localhost:5432/prefect"`

---

## Contact
Feel free to reach out to me if you have any questions, comments, suggestions, or feedback: [theDataFixer.xyz](https://thedatafixer.xyz/)
