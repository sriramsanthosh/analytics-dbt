{{ config(materialized='view') }}

select
    id              as order_id,
    id              as customer_id,
    order_date,
    status
    
from {{ source('jaffle_shop', 'orders') }}
where status != 'returned'