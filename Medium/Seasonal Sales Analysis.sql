/*
LeetCode 3564. Seasonal Sales Analysis

Difficulty: Medium

Problem Statement:
Given two tables, sales and products, find the most popular product
category for each season.

Seasons:
- Winter: December, January, February
- Spring: March, April, May
- Summer: June, July, August
- Fall: September, October, November

Popularity is determined by:
1. Highest total quantity sold in the season.
2. If tied, highest total revenue (quantity * price).
3. If still tied, lexicographically smaller category.

Return:
- season
- category
- total_quantity
- total_revenue

Order the result by season in ascending order.

Tables:

sales:
- sale_id
- product_id
- sale_date
- quantity
- price

products:
- product_id
- product_name
- category

Approach:
1. Join sales with products using product_id.
2. Determine the season from sale_date.
3. Group by season and category.
4. Calculate total quantity and total revenue.
5. Rank categories within each season using:
   - total quantity DESC
   - total revenue DESC
   - category ASC
6. Select the first-ranked category from each season.

*/

WITH season_sales AS (
    SELECT
        CASE
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
        END AS season,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY
        CASE
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
        END,
        p.category
),

ranked AS (
    SELECT
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY
                total_quantity DESC,
                total_revenue DESC,
                category ASC
        ) AS rn
    FROM season_sales
)

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked
WHERE rn = 1
ORDER BY
    CASE season
        WHEN 'Fall' THEN 1
        WHEN 'Spring' THEN 2
        WHEN 'Summer' THEN 3
        WHEN 'Winter' THEN 4
    END;
