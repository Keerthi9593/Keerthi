WITH source AS (
    SELECT * FROM {{ source('sales', 'stores') }}
)

SELECT
    STORE_ID,
    {{ clean_string('STORE_NAME') }} AS STORE_NAME,
    PHONE,
    TRIM(LOWER(EMAIL)) AS EMAIL,
    {{ full_address('STREET', 'CITY', 'STATE', 'ZIP_CODE') }} AS FULL_ADDRESS,
    {{ clean_string('STREET') }} AS STREET,
    {{ clean_string('CITY') }} AS CITY,
    {{ clean_string('STATE') }} AS STATE,
    ZIP_CODE
FROM source