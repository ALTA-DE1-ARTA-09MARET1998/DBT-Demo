WITH normalized_data AS (
  SELECT
    *,
    {{ normalize_phone_number(raw.customer_phone) }} AS normalized_customer_phone
  FROM
    stg_order_details
)

SELECT
  *,
  CASE
    WHEN normalized_customer_phone LIKE '62%' THEN 'Indonesia'
    WHEN normalized_customer_phone LIKE '91%' THEN 'India'
    ELSE 'Unknown'
  END AS country
FROM
  normalized_data;
