WITH CallersWithStatus AS (
    SELECT
        CASE
            WHEN call_category = 'n/a' OR call_category IS NULL THEN 1
            ELSE 0
        END AS call_category_status
    FROM callers
)
SELECT
    ROUND(
        SUM(call_category_status) * 100.0 / COUNT(call_category_status),
        1
    ) AS uncategorised_call_pct
FROM CallersWithStatus;
