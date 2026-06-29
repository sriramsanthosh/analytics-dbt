-- Test: campaign spend should not exceed budget by more than 10%
-- Fails if any campaign overspent beyond 10% of its budget

select
    campaign_id,
    campaign_name,
    budget,
    spend,
    round((spend - budget) / nullif(budget, 0) * 100, 2) as overspend_pct
from {{ ref('stg_campaigns') }}
where spend > budget * 1.10
