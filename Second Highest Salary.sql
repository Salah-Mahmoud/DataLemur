WITH RankedSalaries AS (
  SELECT
    salary,
    RANK() OVER(
      ORDER BY salary DESC
    ) AS Rank
  FROM employee
)
SELECT DISTINCT salary
FROM RankedSalaries
WHERE Rank = 2;
