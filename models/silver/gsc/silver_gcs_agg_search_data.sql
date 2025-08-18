{{ config(alias = 'agg_search_data') }}


with flatten_data as (
SELECT
    restaurant_id,
    domain,
    replace(domain, '.com', '') as second_level_domain,
    _updated_at,
    _created_at,
    t1.value:clicks::NUMBER AS clicks,
    t1.value:ctr::NUMBER(5,4) AS ctr,
    t1.value:impressions::NUMBER AS impressions,
    t2.value::VARCHAR AS search_text,
    replace(replace(replace(search_text, ' ', ''), '’', ''), '\'', '') as search_text_no_spaces,
    t1.value:position::NUMBER(5,2) AS position
FROM
    PC_FIVETRAN_DB.DATA_OUTPUTS.HEX_CASE_GSC_EXPORT,
    LATERAL FLATTEN(INPUT => PARSE_JSON(data):rows) t1,
    LATERAL FLATTEN(INPUT => t1.value:keys) t2

select 
    *,

    --Branded/Unbranded identificaiton
    second_level_domain = search_text_no_spaces as is_perfect_match,

    contains(search_text_no_spaces, second_level_domain) as is_contained,

    JAROWINKLER_SIMILARITY(second_level_domain, search_text_no_spaces) as j_similarity,

    j_similarity > 96 as has_high_j_similarity,

    EDITDISTANCE(second_level_domain, search_text_no_spaces) as edit_distance,

    edit_distance < 2 as has_low_edit_distance,

    is_contained or has_high_j_similarity or has_low_edit_distance as is_branded_search
    
from flatten_data
