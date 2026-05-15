{% macro calculate_net_price(quantity, list_price, discount) %}
    ({{ quantity }} * {{ list_price }} * (1 - {{ discount }}))
{% endmacro %}