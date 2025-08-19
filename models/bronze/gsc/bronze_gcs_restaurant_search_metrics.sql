{{ config(alias = 'agg_search_data') }}


select 
    restaurant_id,	
    domain,	
    _updated_at,	
    _created_at,	
    status,	
    data
from {{ source('gsc', 'hex_case_gsc_export')}}


