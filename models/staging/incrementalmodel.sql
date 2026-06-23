{{
    config(materialized = 'incremental', unique_key = ['order_id', 'product_id'])
}}

select
    order_id, 
    customer_id,
    order_data,
    amount
from {{source('jaffle_shop', 'orders')}}

{% if is_incremental() %}
where order_date>(select max(order_data) from {{this}})
{% endif %}