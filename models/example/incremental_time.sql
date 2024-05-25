
{{
    config(
        materialized='incremental',
        unique_key='t_time'
    )
}}

select *
from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
where  to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) <=   current_time

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  and t_time > (select max(t_time) from {{ this }})
  
{% endif %}