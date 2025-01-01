WITH earliest_issues_cte AS (
    SELECT
        card_name,
        issued_amount,
        DENSE_RANK() OVER (
            PARTITION BY card_name
            ORDER BY issue_year, issue_month
        ) AS issue_rank
    FROM
        monthly_cards_issued
)
SELECT
    card_name,
    issued_amount
FROM
    earliest_issues_cte
WHERE
    issue_rank = 1
ORDER BY
    issued_amount DESC;
