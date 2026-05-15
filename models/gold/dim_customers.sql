WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

customer_orders AS (
    SELECT
        CUSTOMER_ID,
        COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS,
        SUM(NET_PRICE) AS TOTAL_SPEND,
        MIN(ORDER_DATE) AS FIRST_ORDER_DATE,
        MAX(ORDER_DATE) AS LAST_ORDER_DATE,
        AVG(NET_PRICE) AS AVG_ORDER_LINE_VALUE
    FROM {{ ref('fct_sales') }}
    GROUP BY CUSTOMER_ID
)

SELECT
    c.CUSTOMER_ID,
    c.FULL_NAME,
    c.EMAIL,
    c.PHONE,
    c.FULL_ADDRESS,
    c.CITY,
    c.STATE,
    c.ZIP_CODE,
    COALESCE(co.TOTAL_ORDERS, 0) AS TOTAL_ORDERS,
    COALESCE(co.TOTAL_SPEND, 0) AS TOTAL_SPEND,
    co.FIRST_ORDER_DATE,
    co.LAST_ORDER_DATE,
    COALESCE(co.AVG_ORDER_LINE_VALUE, 0) AS AVG_ORDER_LINE_VALUE
FROM customers c
LEFT JOIN customer_orders co ON c.CUSTOMER_ID = co.CUSTOMER_ID