{{ config(alias = 'restaurant_search_metrics')}}



select 
    *
from {{ ref('silver_fct_restaurant_search_metrics')}}