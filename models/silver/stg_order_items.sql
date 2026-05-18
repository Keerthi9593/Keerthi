{{ config(
    materialized='incremental',
    unique_key='order_item_key'
) }}

WITH source AS (
    SELECT * FROM {{ source('sales', 'order_items') }}
)

SELECT
    {{ generate_surrogate_key(['ORDER_ID', 'ITEM_ID']) }} AS ORDER_ITEM_KEY,
    ORDER_ID,
    ITEM_ID,
    PRODUCT_ID,
    QUANTITY,
    LIST_PRICE,
    DISCOUNT,
    {{ calculate_net_price('QUANTITY', 'LIST_PRICE', 'DISCOUNT') }} AS NET_PRICE
FROM source