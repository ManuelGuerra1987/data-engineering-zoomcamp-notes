{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *
  from {{ source('staging','FHV_2019') }}
  where dispatching_base_num is not null 
)
select

    dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropOff_datetime,
    PUlocationID,
    DOlocationID,
    SR_Flag,
    Affiliated_base_number
    

from tripdata

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}