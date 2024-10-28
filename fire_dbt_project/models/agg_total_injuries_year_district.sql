{{
    config(
        materialized='view'
    )
}}
SELECT
    t.year,
    d.district_name,
    COUNT(f.incident_id) AS total_incidents,
    SUM(f.fire_injuries + f.civilian_injuries) AS total_injuries
FROM
    {{ ref('fire_incidents_fact') }} f
JOIN
    {{ ref('dim_time') }} t ON f.time_id = t.date
JOIN
    {{ ref('dim_district') }} d ON f.district_id = d.district_id
GROUP BY
    t.year, d.district_name
ORDER BY
    t.year, d.district_name
