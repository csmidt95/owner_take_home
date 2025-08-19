
/*
The output of this query can be used to look at unbranded vs branded performance of restaurants at the restaurant level

Note: part of requirements specified '% of searches', I am using # of Impressions as the # of searches
*/

select 
    restaurant_id,
    domain,

    --Branded Metrics
    sum(iff(is_branded_search, impressions, null)) as branded_impressions,
    sum(iff(is_branded_search, clicks, null)) as branded_clicks,
    branded_clicks/branded_impressions as branded_ctr,
    sum(iff(is_branded_search, impressions * position, null)) / sum(iff(is_branded_search, position, null)) as branded_position,
   

    --Unbranded Metrics
    sum(iff(not is_branded_search, impressions, null)) as unbranded_impressions,
    sum(iff(not is_branded_search, clicks, null)) as unbranded_clicks,
    unbranded_clicks/unbranded_impressions as unbranded_ctr,
    sum(iff(not is_branded_search, impressions * position, null)) / sum(iff(not is_branded_search, position, null)) as unbranded_position,

    --Totals
    sum(impressions) as total_impressions,
    sum(clicks) as total_clicks,
    total_clicks/total_impressions as total_ctr,

    --Ratio
    branded_impressions/total_impressions as perc_branded_impressions,
    branded_clicks/total_clicks as perc_branded_clicks
from {{ ref('gold_product_restaurant_search_metrics')}}
group by 1,2
order by 1,2