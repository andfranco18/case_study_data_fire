{{ config(
    materialized='view'
) }}

WITH enriched_data AS (
    SELECT
        ROW_NUMBER() OVER () AS incident_id,
        "Incident Number" AS incident_number,
        "Exposure Number" AS exposure_number,
        "ID" AS id,
        "Address" AS address,
        STRPTIME("Incident Date", '%Y/%m/%d') AS date,
        "Call Number" AS call_number,
        "Alarm DtTm" AS alarm_dttm,
        "Arrival DtTm" AS arrival_dttm,
        "Close DtTm" AS close_dttm,
        "City" AS city,
        zipcode,
        "Battalion" AS battalion_name,
        "Supervisor District" AS supervisor_district,
        COALESCE("Suppression Units", 0) + COALESCE("EMS Units", 0) + COALESCE("Other Units", 0) AS total_units,
        COALESCE("Suppression Personnel", 0) + COALESCE("EMS Personnel", 0) + COALESCE("Other Personnel", 0) AS total_personnel,
        COALESCE("Estimated Property Loss", 0) AS estimated_property_loss,
        COALESCE("Estimated Contents Loss", 0) AS estimated_contents_loss,
        COALESCE("Fire Fatalities", 0) AS fire_fatalities,
        COALESCE("Fire Injuries", 0) AS fire_injuries,
        COALESCE("Civilian Fatalities", 0) AS civilian_fatalities,
        COALESCE("Civilian Injuries", 0) AS civilian_injuries,
        "Number of Alarms" AS number_of_alarms,
        "Primary Situation" AS primary_situation
    FROM {{ ref('silver_fire_incidents') }}
)

SELECT
    e.incident_id,
    t.date AS time_id,
    d.district_id,
    b.battalion_id,
    e.estimated_property_loss,
    e.estimated_contents_loss,
    e.fire_fatalities,
    e.fire_injuries,
    e.civilian_fatalities,
    e.civilian_injuries,
    e.number_of_alarms,
    e.total_units,
    e.total_personnel
FROM enriched_data e
JOIN {{ ref('dim_time') }} t ON e.date = t.date
JOIN {{ ref('dim_district') }} d ON e.supervisor_district = d.supervisor_district
JOIN {{ ref('dim_battalion') }} b ON e.battalion_name = b.battalion_name
