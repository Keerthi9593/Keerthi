{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

WITH source AS (
    SELECT * FROM {{ source('sales', 'customers') }}
)

SELECT
    CUSTOMER_ID,
    {{ clean_string('FIRST_NAME') }} AS FIRST_NAME,
    {{ clean_string('LAST_NAME') }} AS LAST_NAME,
    {{ full_name('FIRST_NAME', 'LAST_NAME') }} AS FULL_NAME,
    TRIM(LOWER(EMAIL)) AS EMAIL,
    PHONE,
    {{ full_address('STREET', 'CITY', 'STATE', 'ZIP_CODE') }} AS FULL_ADDRESS,
    {{ clean_string('STREET') }} AS STREET,
    {{ clean_string('CITY') }} AS CITY,
    {{ clean_string('STATE') }} AS STATE,
    ZIP_CODE
FROM source