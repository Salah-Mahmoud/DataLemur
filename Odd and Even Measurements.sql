WITH row_num_cte AS (
  SELECT
    CAST(measurement_time AS DATE) AS measurement_day,
    ROW_NUMBER() OVER (PARTITION BY CAST(measurement_time AS DATE) ORDER BY measurement_time) AS row_num,
    measurement_value
  FROM measurements
),
classified_values_cte AS (
  SELECT
    measurement_day,
    CASE 
      WHEN row_num % 2 = 1 THEN measurement_value
      ELSE NULL
    END AS odd,
    CASE
      WHEN row_num % 2 = 0 THEN measurement_value
      ELSE NULL
    END AS even
  FROM row_num_cte
)
SELECT
  measurement_day,
  SUM(odd) as odd_sum,
  SUM(even) as even_sum
FROM classified_values_cte
GROUP BY measurement_day

