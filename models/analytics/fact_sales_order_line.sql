SELECT 
  order_line_id AS sale_order_line_key,
  quantity,
  unit_price
FROM `vit-lam-data.wide_world_importers.sales__order_lines`
