--create stg_order_details--

CREATE TABLE stg_order_details AS
SELECT
  orders.order_date,
  order_details.quantity,
  order_details.price,
  brands.name AS brand_name,
  products.name AS product_name
FROM
  orders
JOIN
  order_details ON orders.order_id = order_details.order_id
JOIN
  products ON order_details.product_id = products.product_id
JOIN
  brands ON products.brand_id = brands.brand_id;

-- create fct_per_brand_daily_sales--
 
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

INSERT INTO fct_per_brand_daily_sales (brand_name, order_date, total_quantity, total_revenue)
SELECT
    brand_name,
    order_date,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS total_revenue
FROM stg_order_details
GROUP BY brand_name, order_date;

SELECT COUNT(*) AS duplicate_count
FROM (
    SELECT order_date, brand_name, COUNT(*) AS count_per_combination
    FROM fct_per_brand_daily_sales
    GROUP BY order_date, brand_name
    HAVING COUNT(*) > 1

insert into customer_phone