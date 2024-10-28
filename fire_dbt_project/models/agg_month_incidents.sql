{{
    config(
        materialized='view'
    )
}}
SELECT
    t.year,
    t.month,
    d.district_name,
    b.battalion_name,
    COUNT(f.incident_id) AS total_incidents,
    SUM(f.estimated_property_loss) AS total_property_loss
FROM
    {{ ref('fire_incidents_fact') }} f
JOIN
    {{ ref('dim_time') }} t ON f.time_id = t.date
JOIN
    {{ ref('dim_district') }} d ON f.district_id = d.district_id
JOIN
    {{ ref('dim_battalion') }} b ON f.battalion_id = b.battalion_id
GROUP BY
    t.year, t.month, d.district_name, b.battalion_name
ORDER BY
    t.year, t.month, d.district_name, b.battalion_name
