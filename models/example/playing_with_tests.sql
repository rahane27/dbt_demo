{{ config(materialized='table') }}

select c_custkey, c_mktsegment,c_acctbal
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER"