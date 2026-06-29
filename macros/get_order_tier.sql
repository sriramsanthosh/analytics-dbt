{% macro get_order_tier(amount_col) %}
    case
        when {{ amount_col }} >= 5000 then 'high'
        when {{ amount_col }} >= 2000 then 'medium'
        else                               'low'
    end
{% endmacro %}