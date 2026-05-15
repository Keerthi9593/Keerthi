{% macro full_address(street, city, state, zip_code) %}
    CONCAT_WS(', ', {{ clean_string(street) }}, {{ clean_string(city) }}, {{ clean_string(state) }}, {{ zip_code }})
{% endmacro %}