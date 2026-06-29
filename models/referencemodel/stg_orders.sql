{{ config(materialized='view') }}

-- b
-- ID NUMBER(38,0),
-- 	FIRST_NAME VARCHAR(16777216),
-- 	LAST_NAME VARCHAR(16777216)

-- a
-- ID NUMBER(38,0),
-- 	USER_ID NUMBER(38,0),
-- 	ORDER_DATE DATE,
-- 	STATUS VARCHAR(16777216),
-- 	_ETL_LOADED_AT TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP()

-- c
-- ID NUMBER(38,0),
-- 	ORDERID NUMBER(38,0),
-- 	PAYMENTMETHOD VARCHAR(16777216),
-- 	STATUS VARCHAR(16777216),
-- 	AMOUNT NUMBER(38,0),
-- 	CREATED DATE,
-- 	_BATCHED_AT 




select a.id,
    a.user_id,
    a.user_id as customer_id,
    a.order_date,
    a.status,
    b.first_name,
    b.last_name,
    b.first_name||b.last_name||'@gmail.com' as email,
    c.orderid as order_id,
    c.paymentmethod,
    c.amount
    -- a.order_id,
    -- a.customer_id,
    -- a.order_date,
    -- a.status,
    -- total_amount
from {{ source('jaffle_shop', 'orders') }} a
left join {{source('jaffle_shop', 'customers')}} b
on a.user_id = b.id
left join {{source('stripe', 'payment')}} c
on a.id = c.orderid
where a.status != 'returned'