{{ config(alias = 'agg_search_data')}}



select 
    *
from {{ ref('silver_gcs_agg_search_data')}}