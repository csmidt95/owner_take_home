{{ config(alias = 'bookings_pacing_report', materialized = 'view')}}


select 
    bsc.*,
    b.booking_start_date,

    --Dimensions
    b.market_segment,
    b.owner_name,
    l.location_name,
    l.site_name,

    --measures
    b.booking_actual_amount,
    b.booking_grand_total
from {{ ref('silver_t2scd_booking_status_changes_t2scd') }} as bsc 
inner join {{ ref('silver_dim_bookings') }} as b 
    on b.booking_id = bsc.booking_id
left join {{ ref('silver_dim_locations') }} as l 
    on b.location_id = l.location_id 
where not b.is_deleted