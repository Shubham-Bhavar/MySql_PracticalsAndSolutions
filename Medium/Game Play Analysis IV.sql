/*
LeetCode 550 - Game Play Analysis IV

Problem:
Find the fraction of players who logged in again on the day
immediately after their first login.

Approach:
1. Find the first login date of every player.
2. Join Activity with these first login dates.
3. Check if event_date = first_date + 1 day.
4. Count such players.
5. Divide by total number of players.
6. Round the result to 2 decimal places.

Example:
Player 1:
First login = 2016-03-01
Next login  = 2016-03-02
So Player 1 qualifies.

Players = 3
Qualifying players = 1

Fraction = 1 / 3 = 0.33
*/

SELECT
    ROUND(
        COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity a
JOIN
(
    SELECT
        player_id,
        MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
) first_login
ON a.player_id = first_login.player_id
AND a.event_date = DATE_ADD(first_login.first_date, INTERVAL 1 DAY);
