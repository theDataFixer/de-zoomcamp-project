from setuptools import find_packages, setup

setup(
    name="zoomcamp-project",
    version="0.0.1",
    author="theDataFixer",
    author_email="ovaldez@tuta.io",
    description="Zoomcamp project",
    packages=find_packages(),
    install_requires=[
        "dlt[duckdb]>=0.4.7",
        "dlt[bigquery]>=0.4.7",
        "alive-progress>=3.1.5",
    ],
    python_requires=">=3.11",
)
