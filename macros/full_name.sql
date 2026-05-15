{% macro full_name(first_name, last_name) %}
    CONCAT({{ clean_string(first_name) }}, ' ', {{ clean_string(last_name) }})
{% endmacro %}