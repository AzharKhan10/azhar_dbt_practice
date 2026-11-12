{% set inc_flag = 1 %}
{% set last_loaded = 3 %}

{% set cols_lists = ["sales_id", "date_sk", "gross_amount"] %}

SELECT 
    {% for i in cols_lists %}
        {{ i }}
        {% if not loop.last %}, {% endif %}
        {% endfor %}
FROM
    {{ ref('bronze_sales') }}
{% if inc_flag == 1 %}
    WHERE date_sk > {{ last_loaded }}
{% endif %}
