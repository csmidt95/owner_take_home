{{ config(alias = 'restaurant_search_metrics')}}



select 
    *
from {{ ref('silver_restaurant_search_metrics')}}