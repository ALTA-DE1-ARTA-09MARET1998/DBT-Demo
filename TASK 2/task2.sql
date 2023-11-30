CREATE TABLE fct_per_brand_daily_sales AS
SELECT
    brand_name,
    order_date,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS total_revenue
FROM
    stg_order_details
GROUP BY
    brand_name,
    order_date;