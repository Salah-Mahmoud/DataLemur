WITH users_last_month AS (
    SELECT DISTINCT user_id
    FROM user_actions
    WHERE event_date BETWEEN '2022-06-01' AND '2022-06-30'
),
users_current_month AS (
    SELECT DISTINCT user_id
    FROM user_actions
    WHERE event_date BETWEEN '2022-07-01' AND '2022-07-31'
),
active_users AS (
    SELECT user_id
    FROM users_last_month
    INTERSECT
    SELECT user_id
    FROM users_current_month
)
SELECT 
    7 AS month,
    COUNT(user_id) AS monthly_active_users
FROM active_users;
