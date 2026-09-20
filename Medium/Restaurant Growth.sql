/*
    LeetCode 1321 - Restaurant Growth

    Problem:
    --------
    Calculate the 7-day moving average of the total amount
    paid by customers.

    The 7-day window contains:
    Current day + previous 6 days.

    Return:
    - visited_on
    - total amount for the 7-day window
    - average amount for the 7-day window

    average_amount must be rounded to 2 decimal places.

    Order by visited_on in ascending order.

    Approach:
    ---------
    1. First calculate the total amount for each day.
    2. Use a window function to calculate the sum of the
       current day and previous 6 days.
    3. Use ROW_NUMBER() to identify the first 6 days.
    4. Return results only when a complete 7-day window exists.
*/

WITH daily_amount AS
(
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),

seven_day AS
(
    SELECT
        visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,

        ROW_NUMBER() OVER (
            ORDER BY visited_on
        ) AS day_number

    FROM daily_amount
)

SELECT
    visited_on,
    amount,
    ROUND(amount / 7, 2) AS average_amount

FROM seven_day

WHERE day_number >= 7

ORDER BY visited_on ASC;
