SELECT
    ag.age_bucket,
    ROUND(
        100.0 * SUM(CASE WHEN ac.activity_type = 'open' THEN ac.time_spent END) /
        NULLIF(
            SUM(CASE WHEN ac.activity_type IN ('open', 'send') THEN ac.time_spent END),
            0
        ),
        2
    ) AS open_perc,
    ROUND(
        100.0 * SUM(CASE WHEN ac.activity_type = 'send' THEN ac.time_spent END) /
        NULLIF(
            SUM(CASE WHEN ac.activity_type IN ('open', 'send') THEN ac.time_spent END),
            0
        ),
        2
    ) AS send_perc
FROM
    activities ac
JOIN
    age_breakdown ag
ON
    ac.user_id = ag.user_id
GROUP BY
    ag.age_bucket;
