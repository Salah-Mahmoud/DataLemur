WITH international_call_cte AS (
    SELECT
        CASE
            WHEN i1.country_id != i2.country_id THEN 1
            ELSE 0
        END AS is_international_call
    FROM phone_calls c
    JOIN phone_info i1 ON c.caller_id = i1.caller_id
    JOIN phone_info i2 ON c.receiver_id = i2.caller_id
)
SELECT
    ROUND(
        (SUM(is_international_call) * 100.0) / COUNT(is_international_call),
        1
    ) AS international_calls_pct
FROM international_call_cte;
