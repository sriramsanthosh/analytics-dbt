{{
    config(materialized='table')
}}

select 
    c.customer_id,
    c.first_name,
    c.email,
    count(o.order_id) as total_orders,
    sum(o.amount) as totol_spent,
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date
from {{ref('stg_customers_ref')}} c 
left join {{ref('stg_orders')}} o 
    on c.customer_id = o.customer_id
group by 1, 2, 3, 4