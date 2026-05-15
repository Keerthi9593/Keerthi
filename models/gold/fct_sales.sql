WITH order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

stores AS (
    SELECT * FROM {{ ref('stg_stores') }}
),

staffs AS (
    SELECT * FROM {{ ref('stg_staffs') }}
)

SELECT
    oi.ORDER_ITEM_KEY,
    oi.ORDER_ID,
    oi.ITEM_ID,
    o.ORDER_DATE,
    o.SHIPPED_DATE,
    o.ORDER_STATUS_LABEL,
    o.SHIPPING_DELAY_DAYS,
    c.CUSTOMER_ID,
    c.FULL_NAME AS CUSTOMER_NAME,
    c.EMAIL AS CUSTOMER_EMAIL,
    c.CITY AS CUSTOMER_CITY,
    c.STATE AS CUSTOMER_STATE,
    p.PRODUCT_ID,
    p.PRODUCT_NAME,
    p.BRAND_NAME,
    p.CATEGORY_NAME,
    p.MODEL_YEAR,
    st.STORE_ID,
    st.STORE_NAME,
    sf.STAFF_ID,
    sf.FULL_NAME AS STAFF_NAME,
    oi.QUANTITY,
    oi.LIST_PRICE,
    oi.DISCOUNT,
    oi.NET_PRICE
FROM order_items oi
INNER JOIN orders o ON oi.ORDER_ID = o.ORDER_ID
LEFT JOIN products p ON oi.PRODUCT_ID = p.PRODUCT_ID
LEFT JOIN customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
LEFT JOIN stores st ON o.STORE_ID = st.STORE_ID
LEFT JOIN staffs sf ON o.STAFF_ID = sf.STAFF_ID