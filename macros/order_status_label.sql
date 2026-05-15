{% macro order_status_label(status_column) %}
    CASE {{ status_column }}
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
        ELSE 'Unknown'
    END
{% endmacro %}