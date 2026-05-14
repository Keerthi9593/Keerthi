-- {{ config(materialized='incremental') }}

-- select distinct
--     order_id,
--     trim(customer_name) as customer_name,
--     lower(coalesce(email, 'unknown@gmail.com')) as email,
--     coalesce(product_name, 'Unknown Product') as product_name,
--     initcap(coalesce(category, 'Others')) as category,
--     coalesce(quantity, 1) as quantity,
--     price,
--     coalesce(quantity, 1) * price as total_amount,
--     order_date,
--     trim(city) as city

-- from {{ source('bronze', 'CUSTOMER_ORDERS_RAW') }}

-- where customer_name is not null

-- {% if is_incremental() %}

-- and order_id not in
-- (
--     select order_id
--     from {{ this }}
-- )

-- {% endif %}

{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

select distinct
    order_id,
    trim(customer_name) as customer_name,
    lower(coalesce(email, 'unknown@gmail.com')) as email,
    coalesce(product_name, 'Unknown Product') as product_name,
    initcap(coalesce(category, 'Others')) as category,
    coalesce(quantity, 1) as quantity,
    price,
    coalesce(quantity, 1) * price as total_amount,
    order_date,
    trim(city) as city

from {{ source('bronze', 'CUSTOMER_ORDERS_RAW') }}

where customer_name is not null