{{ config(
    materialized='incremental',
    unique_key='staff_id'
) }}

WITH staffs AS (
    SELECT * FROM {{ source('sales', 'staffs') }}
),

stores AS (
    SELECT * FROM {{ source('sales', 'stores') }}
)

SELECT
    s.STAFF_ID,
    {{ full_name('s.FIRST_NAME', 's.LAST_NAME') }} AS FULL_NAME,
    {{ clean_string('s.FIRST_NAME') }} AS FIRST_NAME,
    {{ clean_string('s.LAST_NAME') }} AS LAST_NAME,
    TRIM(LOWER(s.EMAIL)) AS EMAIL,
    s.PHONE,
    s.ACTIVE,
    CASE WHEN s.ACTIVE = 1 THEN 'Active' ELSE 'Inactive' END AS ACTIVE_STATUS,
    s.STORE_ID,
    st.STORE_NAME,
    s.MANAGER_ID
FROM staffs s
LEFT JOIN stores st ON s.STORE_ID = st.STORE_ID