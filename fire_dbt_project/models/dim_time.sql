{{ config(
    materialized='incremental',
    unique_key='date'
) }}

WITH silver_fire_incidents AS (
    SELECT 
        DISTINCT 
        STRPTIME("Incident Date", '%Y/%m/%d')AS date,
        date_part('day', STRPTIME("Incident Date", '%Y/%m/%d')) AS day,
        date_part('month', STRPTIME("Incident Date", '%Y/%m/%d')) AS month,
        date_part('quarter', STRPTIME("Incident Date", '%Y/%m/%d')) AS quarter,
        date_part('year', STRPTIME("Incident Date", '%Y/%m/%d')) AS year,
        date_part('dayofweek', STRPTIME("Incident Date", '%Y/%m/%d')) AS day_of_week
    FROM {{ ref('silver_fire_incidents') }}
)

SELECT
    date,
    day,
    month,
    quarter,
    year,
    day_of_week
FROM silver_fire_incidents
