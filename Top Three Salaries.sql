WITH salary_rank as (
  SELECT
    d.department_name,
    e.name,
    salary,
    DENSE_RANK() OVER(
    PARTITION BY department_name ORDER BY salary DESC
    ) as RANK
  FROM employee e
  JOIN department d
  ON e.department_id = d.department_id
)
SELECT
  department_name,
  name,
  salary
FROM salary_rank
WHERE RANK <=3
ORDER BY department_name,salary DESC,name
