/*
LeetCode 3580. Find Consistently Improving Employees

Difficulty: Medium

Problem Statement:
Find employees who have consistently improved their performance
over their last three reviews.

Requirements:
1. An employee must have at least 3 reviews.
2. Use the most recent 3 reviews based on review_date.
3. The ratings of these 3 reviews must be strictly increasing.
4. Calculate the improvement_score as:
   latest rating - earliest rating
5. Return employee_id, name, and improvement_score.
6. Order by improvement_score in descending order,
   then by name in ascending order.

Tables:

employees
- employee_id
- name

performance_reviews
- review_id
- employee_id
- review_date
- rating

Example Output:
+-------------+---------------+-------------------+
| employee_id | name          | improvement_score |
+-------------+---------------+-------------------+
| 2           | Bob Smith     | 3                 |
| 1           | Alice Johnson | 2                 |
| 3           | Carol Davis   | 2                 |
+-------------+---------------+-------------------+

Approach:
1. Rank each employee's reviews from newest to oldest.
2. Keep only the latest 3 reviews.
3. Check that the three ratings are strictly increasing
   from oldest to newest.
4. Calculate the improvement score.
5. Join with employees to get the employee name.
6. Sort by improvement score DESC and name ASC.
*/

WITH ranked_reviews AS (
    SELECT
        employee_id,
        rating,
        review_date,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn
    FROM performance_reviews
),

last_three AS (
    SELECT
        employee_id,
        rating,
        review_date
    FROM ranked_reviews
    WHERE rn <= 3
),

ordered_reviews AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date
        ) AS review_order
    FROM last_three
),

employee_scores AS (
    SELECT
        employee_id,
        MAX(CASE WHEN review_order = 1 THEN rating END) AS earliest_rating,
        MAX(CASE WHEN review_order = 2 THEN rating END) AS middle_rating,
        MAX(CASE WHEN review_order = 3 THEN rating END) AS latest_rating
    FROM ordered_reviews
    GROUP BY employee_id
)

SELECT
    e.employee_id,
    e.name,
    s.latest_rating - s.earliest_rating AS improvement_score
FROM employee_scores s
JOIN employees e
    ON e.employee_id = s.employee_id
WHERE s.earliest_rating < s.middle_rating
  AND s.middle_rating < s.latest_rating
ORDER BY
    improvement_score DESC,
    e.name ASC;