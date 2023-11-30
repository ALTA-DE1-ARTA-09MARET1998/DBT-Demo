{% macro normalize_phone_number(phone_number) %}
  {% set normalized_phone = regex_replace(phone_number, '[^0-9]', '', 0) %}
  {% set country_code = left(normalized_phone, 2) %}

  {% if length(normalized_phone) > 2 %}
    {{ normalized_phone }}
  {% else %}
    NULL
  {% endif %}
{% endmacro %}

{% macro country_code(country) %}

    case
        when trim(lower({{ country }})) = "Indonesia" then "62"
        when trim(lower({{ country }})) = "India" then "91"
    end

{% endmacro %}