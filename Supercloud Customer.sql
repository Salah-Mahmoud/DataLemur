WITH product_categories AS (
    SELECT DISTINCT product_category
    FROM products
),
customer_purchases AS (
    SELECT customer_id, product_category
    FROM customer_contracts c
    JOIN products p
    ON c.product_id = p.product_id
    GROUP BY customer_id, product_category
),
supercloud_customers AS (
    SELECT customer_id
    FROM customer_purchases cp
    GROUP BY customer_id
    HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(*) FROM product_categories)
)
SELECT customer_id
FROM supercloud_customers;
