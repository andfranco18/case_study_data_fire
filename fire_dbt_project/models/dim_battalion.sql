{{ config(
    materialized='incremental',
    unique_key='battalion_id'
) }}
with silver_fire_incidents as (
    SELECT *
    FROM {{ ref('silver_fire_incidents') }}
)
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY "Battalion") AS battalion_id,
    "Battalion" AS battalion_name,
    "Station Area" AS station_area
FROM silver_fire_incidents
