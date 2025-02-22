{{ config(materialized='table') }}

with trips_data as (
    select *,
        EXTRACT(YEAR FROM pickup_datetime) AS year,
        EXTRACT(QUARTER FROM pickup_datetime) AS quarter,
        EXTRACT(MONTH FROM pickup_datetime) AS month,
        CONCAT(EXTRACT(YEAR FROM pickup_datetime), '/Q', EXTRACT(QUARTER FROM pickup_datetime)) AS year_quarter 
        
    from {{ ref('fact_trips') }}
)
SELECT

service_type, 
year,
quarter,
sum(total_amount) as revenue,

FROM trips_data

GROUP BY year,quarter