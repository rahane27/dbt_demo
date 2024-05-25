

{{ config(materialized='table') }}

with data as (
select o_orderdate as datee,sum(o_totalprice) as tot_sum from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"  
group by 1 )

select
  datee,tot_sum,
  sum(tot_sum) over (order by datee asc rows between unbounded preceding and current row) as cum_sum
from data