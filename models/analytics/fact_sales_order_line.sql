WITH fact_sales_order_line__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.sales__order_lines`
), fact_sales_order_line__rename AS (
  SELECT 
    order_line_id AS sale_order_line_key,
    order_id AS sale_order_key,
    stock_item_id AS product_key,
    quantity ,
    unit_price 
  FROM fact_sales_order_line__source 
), fact_sales_order_line__cast AS(
  SELECT 
  CAST(sale_order_line_key AS INTEGER )AS sale_order_line_key,
  CAST(sale_order_key AS INTEGER) AS sale_order_key,
  CAST(product_key AS INTEGER) AS product_key,
  CAST(quantity AS INTEGER) AS quantity,
  CAST(unit_price AS NUMERIC) AS unit_price,
  FROM fact_sales_order_line__rename
), fact_sales_order_line__calculate_measure AS (
  SELECT *,
     quantity*unit_price AS  gross_amount
  FROM fact_sales_order_line__cast
)

SELECT 
  fact_line.sale_order_line_key,
  fact_line.sale_order_key,
  fact_header.customer_key,
  fact_line.product_key,
  fact_line.quantity,
  fact_line.unit_price,
  fact_line.gross_amount
FROM fact_sales_order_line__calculate_measure AS fact_line
LEFT JOIN {{ref('stg_fact_sales_order')}} AS fact_header
ON fact_line.sale_order_key = fact_header.sale_order_key

