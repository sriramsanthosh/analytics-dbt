{{ config(materialized='table') }}

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    count(o.order_id)                               as total_orders,
    sum(o.amount)                                   as total_spent,
    sum(case when o.order_tier = 'high'
        then 1 else 0 end)                          as high_value_orders,
    min(o.order_date)                               as first_order_date,
    max(o.order_date)                               as last_order_date
from {{ ref('stg_orders') }} c
left join {{ ref('int_orders_filtered') }} o
    on c.customer_id = o.customer_id
group by 1, 2, 3, 4