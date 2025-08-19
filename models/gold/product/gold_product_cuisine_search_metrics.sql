{{ config(alias = 'cuisine_search_metrics')}}



select 
    rsm.*,
    rc.cuisine
from {{ ref('gold_product_restaurant_search_metrics')}} as rsm
left join {{ ref('silver_dim_restaurant_cuisines')}} as rc 
    on rsm.restaurant_id = rc.restaurant_id