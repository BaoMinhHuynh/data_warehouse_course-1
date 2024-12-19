WITH fact_sales_order_source AS (
    SELECT *
    FROM `vit-lam-data.wide_world_importers.sales__orders`
), fact_sales_order__rename AS(
    SELECT 
        order_id AS sale_order_key,
        customer_id AS customer_key
    FROM fact_sales_order_source
), fact_sales_order__cast AS(
    SELECT 
        CAST(sale_order_key AS INTEGER) AS sale_order_key,
        CAST(customer_key AS INTEGER) AS customer_key
    FROM fact_sales_order__rename
)
SELECT 
    sale_order_key,
    customer_key
FROM fact_sales_order__cast