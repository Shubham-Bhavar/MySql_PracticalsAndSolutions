/*
    LeetCode 3705 - Find Golden Hour Customers

    Problem:
    --------
    Find customers who satisfy ALL of these conditions:

    1. Made at least 3 orders.
    2. At least 60% of their orders were during peak hours:
       11:00-14:00 or 18:00-21:00.
    3. Average rating of rated orders is at least 4.0.
    4. At least 50% of their orders have a rating.

    Return:
    customer_id,
    total_orders,
    peak_hour_percentage,
    average_rating

    Round peak_hour_percentage and average_rating to 2 decimal places.

    Order by average_rating DESC, then customer_id DESC.
*/

SELECT
    customer_id,

    COUNT(*) AS total_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
                  OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS peak_hour_percentage,

    ROUND(
        AVG(order_rating),
        2
    ) AS average_rating

FROM restaurant_orders

GROUP BY customer_id

HAVING
    COUNT(*) >= 3

    AND
    SUM(
        CASE
            WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
              OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
            THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) >= 60

    AND
    AVG(order_rating) >= 4.0

    AND
    COUNT(order_rating) * 100.0 / COUNT(*) >= 50

ORDER BY
    average_rating DESC,
    customer_id DESC;
