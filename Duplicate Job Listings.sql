WITH job_count AS (
  SELECT
    company_id
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*)>1
)

SELECT COUNT(*) AS duplicate_companies
FROM job_count
