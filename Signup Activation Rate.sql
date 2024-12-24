WITH active_cte AS (
  SELECT
    CASE
      WHEN signup_action = 'Confirmed' THEN 1 ELSE 0
    END AS active_status
  FROM
    texts
)
SELECT
  ROUND((SUM(active_status::NUMERIC) / COUNT(active_status::NUMERIC)),2) AS confirm_rate
FROM
  active_cte;
