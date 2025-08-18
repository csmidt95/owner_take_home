{{ config(alias = 'restaurant_cuisines') }}


select 
    restaurant_id,
    cuisines
from {{ source('app_db', 'hex_brand_cuisine_export')}}