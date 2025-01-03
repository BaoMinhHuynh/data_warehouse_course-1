WITH dim_supplier__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.purchasing__suppliers`
), dim_supplier__rename AS (
  SELECT 
    supplier_id AS supplier_key,
    supplier_name
  FROM dim_supplier__source
), dim_supplier__cast AS (
  SELECT
    CAST(supplier_key AS INTEGER) AS supplier_key,
    CAST(supplier_name AS STRING) AS supplier_name
  FROM dim_supplier__rename
)
SELECT *
FROM dim_supplier__cast
