WITH rank_transaction_date AS (
    SELECT
        user_id,
        transaction_date,
        DENSE_RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS rank_transaction_date
    FROM
        user_transactions
),
last_transaction_date AS (
    SELECT
        user_id,
        transaction_date
    FROM
        rank_transaction_date
    WHERE
        rank_transaction_date = 1
)
SELECT
    user_id,
    transaction_date,
    COUNT(*) AS purchase_count
FROM
    last_transaction_date
GROUP BY
    user_id,
    transaction_date
ORDER BY
    transaction_date;
