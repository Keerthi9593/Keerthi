{{ config(
    materialized='incremental',
    unique_key='stock_key'
) }}

WITH stocks AS (
    SELECT * FROM {{ source('production', 'stocks') }}
),

products AS (
    SELECT * FROM {{ source('production', 'products') }}
),

stores AS (
    SELECT * FROM {{ source('sales', 'stores') }}
)

SELECT
    {{ generate_surrogate_key(['sk.STORE_ID', 'sk.PRODUCT_ID']) }} AS STOCK_KEY,
    sk.STORE_ID,
    st.STORE_NAME,
    sk.PRODUCT_ID,
    p.PRODUCT_NAME,
    sk.QUANTITY
FROM stocks sk
LEFT JOIN products p ON sk.PRODUCT_ID = p.PRODUCT_ID
LEFT JOIN stores st ON sk.STORE_ID = st.STORE_ID