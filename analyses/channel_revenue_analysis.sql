select
    channel,
    sum(total_revenue) as revenue
from {{ ref('mta_channel_attribution_summary') }}
group by channel
order by revenue desc