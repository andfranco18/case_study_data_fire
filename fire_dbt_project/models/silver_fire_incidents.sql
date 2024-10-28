{{
    config(
        materialized='incremental'
    )
}}
with bronze_fire_incidents as (
    SELECT
        *
    FROM
        {{ source('main', 'bronze_fire_incidents') }}
)
SELECT
    "Incident Number",
    "Exposure Number",
    "ID",
    "Address",
    "Incident Date",
    "Call Number",
    "Alarm DtTm",
    "Arrival DtTm",
    "Close DtTm",
    "City",
    "zipcode",
    "Battalion",
    "Station Area",
    "Box",
    "Suppression Units",
    "Suppression Personnel",
    "EMS Units",
    "EMS Personnel",
    "Other Units",
    "Other Personnel",
    "First Unit On Scene",
    "Estimated Property Loss",
    "Estimated Contents Loss",
    "Fire Fatalities",
    "Fire Injuries",
    "Civilian Fatalities",
    "Civilian Injuries",
    "Number of Alarms",
    "Primary Situation",
    "Mutual Aid",
    "Action Taken Primary",
    "Action Taken Secondary",
    "Action Taken Other",
    "Detector Alerted Occupants",
    "Property Use",
    "Area of Fire Origin",
    "Ignition Cause",
    "Ignition Factor Primary",
    "Ignition Factor Secondary",
    "Heat Source",
    "Item First Ignited",
    "Human Factors Associated with Ignition",
    "Structure Type",
    "Structure Status",
    "Floor of Fire Origin",
    "Fire Spread",
    "No Flame Spread",
    "Number of floors with minimum damage",
    "Number of floors with significant damage",
    "Number of floors with heavy damage",
    "Number of floors with extreme damage",
    "Detectors Present",
    "Detector Type",
    "Detector Operation",
    "Detector Effectiveness",
    "Detector Failure Reason",
    "Automatic Extinguishing System Present",
    "Automatic Extinguishing Sytem Type",
    "Automatic Extinguishing Sytem Perfomance",
    "Automatic Extinguishing Sytem Failure Reason",
    "Number of Sprinkler Heads Operating",
    "Supervisor District",
    "neighborhood_district",
    "point",
    "data_as_of",
    "data_loaded_at"
from bronze_fire_incidents
{% if is_incremental() %}
where data_loaded_at >= (select coalesce(max(data_loaded_at),'1900-01-01') from {{ this }} )
{% endif %}
