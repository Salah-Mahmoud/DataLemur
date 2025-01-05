WITH yearly_spend_cte AS (
  SELECT
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    SUM(spend) AS total_spend
  FROM
    user_transactions
  GROUP BY
    EXTRACT(YEAR FROM transaction_date),
    product_id
),
previous_spend_cte AS (
  SELECT
    year,
    product_id,
    total_spend AS current_year_spend,
    LAG(total_spend, 1) OVER (
      PARTITION BY product_id
      ORDER BY year
    ) AS previous_year_spend
  FROM
    yearly_spend_cte
),
rate_comparison_cte AS (
  SELECT
    year,
    product_id,
    current_year_spend,
    previous_year_spend,
    ROUND(CASE
      WHEN previous_year_spend IS NULL THEN NULL
      ELSE ((current_year_spend - previous_year_spend) * 100.0 / previous_year_spend)
    END, 2) AS yoy_rate
  FROM
    previous_spend_cte
)
SELECT *
FROM rate_comparison_cte
ORDER BY
  product_id,
  year;
