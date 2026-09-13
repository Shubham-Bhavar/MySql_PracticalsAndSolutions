/*
========================================================
LeetCode 1141 - User Activity for the Past 30 Days I
========================================================

Problem:
--------
Find the daily active user count for the 30 days ending
on 2019-07-27 (inclusive).

A user is active on a day if they have at least one
activity on that day.

Approach:
---------
1. Filter activity_date between 2019-06-28 and 2019-07-27.
2. Group by activity_date.
3. Count DISTINCT user_id because a user can have
   multiple activities on the same day.

========================================================
*/

SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
