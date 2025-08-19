{{ config(alias = 'restaurant_cuisines') }}


select
    t1.restaurant_id,
    t2.value::varchar as cuisine
from
    {{ ref('bronze_app_db_restaurant_cuisines')}} AS t1,
    LATERAL FLATTEN(INPUT => PARSE_JSON(t1.cuisines)) AS t2