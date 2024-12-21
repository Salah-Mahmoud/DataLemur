WITH category_product_spend AS (
  SELECT
    category,
    product,
    SUM(spend) AS total_spend,
    RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS rank_spend
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)
SELECT
    category,
    product,
    total_spend
FROM category_product_spend
WHERE rank_spend IN (1, 2);
