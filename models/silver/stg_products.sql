{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

WITH products AS (
    SELECT * FROM {{ source('production', 'products') }}
),

brands AS (
    SELECT * FROM {{ source('production', 'brands') }}
),

categories AS (
    SELECT * FROM {{ source('production', 'categories') }}
)

SELECT
    p.PRODUCT_ID,
    {{ clean_string('p.PRODUCT_NAME') }} AS PRODUCT_NAME,
    b.BRAND_NAME,
    c.CATEGORY_NAME,
    p.MODEL_YEAR,
    p.LIST_PRICE
FROM products p
LEFT JOIN brands b ON p.BRAND_ID = b.BRAND_ID
LEFT JOIN categories c ON p.CATEGORY_ID = c.CATEGORY_ID