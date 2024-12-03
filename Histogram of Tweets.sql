WITH user_tweet_counts AS (
  SELECT
    user_id,
    count(*) AS tweet_count
  FROM tweets
  WHERE extract(year FROM tweet_date) = 2022
  GROUP BY user_id
)

SELECT
  tweet_count AS tweet_bucket,
  count(DISTINCT user_id) AS users_num
FROM user_tweet_counts
GROUP BY tweet_count;