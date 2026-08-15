/*
Table: Logins

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+

Question:
Find the latest login for every user in the year 2020.

Do not include users who did not log in during 2020.
*/

SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE time_stamp >= '2020-01-01'
  AND time_stamp < '2021-01-01'
GROUP BY user_id;
