{% snapshot snap_product_prices %}

{{
    config(
        target_schema   = 'SNAPSHOTS',
        target_database = 'Dev_ANALYTICS',
        unique_key      = 'product_id',
        strategy        = 'timestamp',
        updated_at      = 'launched_at'
    )
}}

select
    product_id,
    product_name,
    price,
    cost_price,
    is_active,
    launched_at
from {{ source('products', 'products') }}

{% endsnapshot %}