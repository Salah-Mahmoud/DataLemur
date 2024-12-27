WITH MAX_NUM AS (
  SELECT MAX(order_id) AS max_num
  FROM orders
)

SELECT
  CASE
    WHEN order_id % 2 != 0 AND (SELECT max_num FROM MAX_NUM) = order_id THEN order_id
    WHEN order_id % 2 = 0 THEN order_id - 1
    WHEN order_id % 2 != 0 THEN order_id + 1
  END AS corrected_order_id,
  item
FROM orders
ORDER BY corrected_order_id;
