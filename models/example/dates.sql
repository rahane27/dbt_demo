
{{
    config(
        materialized='incremental'
    )
}}

select * from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM
where d_date <= current_date

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  and  d_date > ( select max(d_date)  from {{ this }})

{% endif %}