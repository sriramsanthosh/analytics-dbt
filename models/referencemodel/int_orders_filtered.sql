{{
config(materialized = 'ephemeral')
}}

select order_id,
customer_id,
order_date,
amount,
case when amount >='100' then 'high'
when amount >= '50' then 'medium'
else 'low'
end as order_tier

from {{ref('stg_orders')}}
where status!='returned'