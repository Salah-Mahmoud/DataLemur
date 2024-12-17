WITH user_ranked_transactions AS (
  SELECT
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY transaction_date
    ) AS row_num
  FROM transactions
)
SELECT
  user_id,
  spend,
  transaction_date
FROM user_ranked_transactions
WHERE row_num = 3
