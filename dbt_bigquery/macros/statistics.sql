{#
    This macro extracts some column stats
#}

{% macro stat_aggregations(column_name) -%}
    MIN({{ column_name }}) AS min_{{ column_name | replace('.', '_') }},
    AVG({{ column_name }}) AS avg_{{ column_name | replace('.', '_') }},
    MAX({{ column_name }}) AS max_{{ column_name | replace('.', '_') }}
{% endmacro %}
