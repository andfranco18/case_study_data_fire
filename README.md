# Case Study - Data of Fire - DE Challenge
A customer requires the analysis of a fire incidents dataset for the city of San Francisco. To facilitate this, the data needs to be made accessible in a data warehouse. The business intelligence team must be able to aggregate incident data across multiple dimensions:

- **Time Period**:  incidents by day, month, year.
- **District**: incidents based on city districts.
- **Battalion**: incidents by battalion numbers.

The purpose of this challenge was to simulate the construction of a database using `DuckDB` and to perform all `ELT` processes with `dbt`, facilitating the creation and maintenance of the data model. I use `make` to automate tasks such as setting up the environment and running the pipeline.


### SQL Models
- **`agg_month_incidents.sql`**: Gold Tier, fire incidents by month, providing a time-based summary of incident occurrences.
- **`agg_total_injuries.sql`**: Gold Tier, total injuries related to fire incidents, enabling analysis of incident severity.
- **`dim_battalion.sql`**: battalion dimension
- **`dim_district.sql`**: district dimension, organizing data by districts.
- **`dim_time.sql`**: time dimension, facilitate aggregations by (day, month, quarter, year, day_of_week).
- **`fire_incidents_facts.sql`**: fact table for fire incidents, enriched with the dimensions
- **`silver_fire_incidents.sql`**: Provides a silver-tiered view of fire incidents.


## Prerequisites
- **Python 3.11.6**
- **GNU Make 3.81**

## Makefile Commands
The following `make` commands are available to manage the solution
### Available Commands
| Command        | Description                                   |
| -------------- | --------------------------------------------- |
| `make help`    | Show the list of available commands.          |
| `make create`  | Create a virtual environment.                 |
| `make install` | Install dependencies from `requirements.txt`. |
| `make activate`| Activate the virtual environment.             |
| `make clean`   | Remove the virtual environment and temporary files. |
| `make run`     | Run the application script and dbt models.    |

 ## Project Structure

- **create_bronze.py**: Helper Script to initialize the duckdb.
- **fire_dbt_project**: Directory containing dbt models and configurations.

## Notes

- **dbt conf**: This Makefile assumes dbt profiles are stored in the `fire_dbt_project` folder under your root directory, aligning with dbt's structure.

