{{ config(
    materialized='incremental',
    unique_key='district_id'
) }}
with silver_fire_incidents as (
    SELECT *
    FROM {{ ref('silver_fire_incidents') }}
)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY "Supervisor District") AS district_id,
    "Supervisor District" AS supervisor_district,
    neighborhood_district AS district_name
FROM silver_fire_incidents
