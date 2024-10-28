import pandas as pd
import duckdb
import requests
import os
from datetime import datetime


def create_bronze_table(csv_file, db_path):
    df = pd.read_csv(csv_file, low_memory=False)
    df['ingestion_date'] = datetime.now()
    os.makedirs(os.path.dirname(db_path), exist_ok=True)
    conn = duckdb.connect(f"{db_path}")
    tbl_name = "bronze_fire_incidents"
    conn.execute(f"CREATE OR REPLACE TABLE {tbl_name} AS SELECT * FROM df")
    print(f"DuckDB database created successfully with the '{tbl_name}' table.")
    conn.close()

def download_data(url, output_file):
    if os.path.exists(output_file):
        print(f"File '{output_file}' already exists. Skipping download.")
        return
    print(f"Downloading data from {url}...")
    response = requests.get(url)
    with open(output_file, "wb") as file:
        file.write(response.content)
    print(f"Data downloaded and saved as {output_file}")

if __name__ == "__main__":
    url = "https://data.sfgov.org/api/views/wr8u-xric/rows.csv?accessType=DOWNLOAD"
    output_file = "data/fire_incidents.csv"
    db_path = "data/db/fire_incidents.db"
    download_data(url, output_file)
    create_bronze_table(output_file, db_path)
