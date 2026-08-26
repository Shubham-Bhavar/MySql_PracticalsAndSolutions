/*
Question:
Find the percentage of users registered in each contest.

Formula:
Percentage = (Number of users registered in a contest / Total number of users) * 100

Approach:
1. Group registrations by contest_id.
2. Count the users registered in each contest.
3. Divide by the total number of users.
4. Multiply by 100 and round to 2 decimal places.
5. Sort by percentage in descending order.
6. If percentages are equal, sort by contest_id in ascending order.
*/

SELECT
    contest_id,
    ROUND(
        COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users),
        2
    ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
