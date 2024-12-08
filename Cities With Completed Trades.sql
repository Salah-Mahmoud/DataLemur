SELECT
  city,
  COUNT(order_id) AS total_orders
FROM trades t
JOIN users u
ON t.user_id = u.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3;