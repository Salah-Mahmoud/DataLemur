WITH ranked_highest_open_cte AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS month_year,
    open AS highest_open,
    DENSE_RANK() OVER (PARTITION BY ticker ORDER BY open DESC) AS highest_rank
  FROM stock_prices
),
ranked_lowest_open_cte AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS month_year,
    open AS lowest_open,
    DENSE_RANK() OVER (PARTITION BY ticker ORDER BY open ASC) AS lowest_rank
  FROM stock_prices
)
SELECT
  h.ticker,
  h.month_year AS highest_mth,
  h.highest_open,
  l.month_year AS lowest_mth,
  l.lowest_open
FROM ranked_highest_open_cte h
JOIN ranked_lowest_open_cte l
  ON h.ticker = l.ticker
  AND h.highest_rank = 1
  AND l.lowest_rank = 1
