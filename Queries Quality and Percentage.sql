/*
LeetCode: 1211. Queries Quality and Percentage

Problem:
For each query_name, calculate:

1. Quality:
   Average of (rating / position)

2. Poor Query Percentage:
   Percentage of queries where rating < 3.

Both values should be rounded to 2 decimal places.

Approach:
1. GROUP BY query_name.
2. Calculate average of rating / position for quality.
3. Count ratings less than 3 using CASE WHEN.
4. Divide poor queries by total queries and multiply by 100.
5. ROUND both results to 2 decimal places.

Time Complexity: O(n)
Space Complexity: O(n)
*/

SELECT
    query_name,

    ROUND(
        AVG(rating / position),
        2
    ) AS quality,

    ROUND(
        SUM(
            CASE
                WHEN rating < 3 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS poor_query_percentage

FROM Queries

GROUP BY query_name;
