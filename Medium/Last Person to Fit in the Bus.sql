/*
LeetCode 1204 - Last Person to Fit in the Bus

Approach:
1. Order people by their turn.
2. Calculate cumulative (running) weight.
3. Keep only people whose total weight <= 1000.
4. Return the last person who can fit.

SUM(weight) OVER (ORDER BY turn)
gives the running total.

*/

WITH bus AS
(
    SELECT
        person_name,
        turn,
        SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
)

SELECT person_name
FROM bus
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;
