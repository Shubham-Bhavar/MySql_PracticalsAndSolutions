/*
============================================================
LEETCODE: Analyze Subscription Conversion
============================================================

TABLE: UserActivity

+-------------------+---------+
| Column Name       | Type    |
+-------------------+---------+
| user_id           | int     |
| activity_date     | date    |
| activity_type     | varchar |
| activity_duration | int     |
+-------------------+---------+

UNIQUE KEY:
(user_id, activity_date, activity_type)

============================================================
PROBLEM:

Find users who converted from free_trial to paid.

For each converted user:

1. Calculate average activity duration during free_trial.
2. Calculate average activity duration during paid.
3. Round both averages to 2 decimal places.
4. Order the result by user_id in ascending order.

============================================================
EXAMPLE:

UserActivity table:

+---------+---------------+--------------+-------------------+
| user_id | activity_date | activity_type| activity_duration |
+---------+---------------+--------------+-------------------+
| 1       | 2023-01-01    | free_trial   | 45                |
| 1       | 2023-01-02    | free_trial   | 30                |
| 1       | 2023-01-10    | paid         | 75                |
| 2       | 2023-02-01    | free_trial   | 55                |
| 2       | 2023-02-10    | cancelled    | 0                 |
+---------+---------------+--------------+-------------------+

RESULT:

+---------+--------------------+-------------------+
| user_id | trial_avg_duration | paid_avg_duration |
+---------+--------------------+-------------------+
| 1       | 37.50              | 75.00             |
+---------+--------------------+-------------------+

User 2 is not included because the user did not convert to paid.

============================================================
APPROACH:

1. Group records by user_id.
2. Use conditional AVG() to calculate:
   - Average duration for free_trial
   - Average duration for paid
3. Use HAVING to keep only users having both:
   - free_trial activity
   - paid activity
4. Round averages to 2 decimal places.
5. Sort by user_id.

============================================================
SOLUTION:
============================================================
*/

SELECT
    user_id,

    ROUND(
        AVG(
            CASE
                WHEN activity_type = 'free_trial'
                THEN activity_duration
            END
        ),
        2
    ) AS trial_avg_duration,

    ROUND(
        AVG(
            CASE
                WHEN activity_type = 'paid'
                THEN activity_duration
            END
        ),
        2
    ) AS paid_avg_duration

FROM UserActivity

GROUP BY user_id

HAVING
    SUM(activity_type = 'free_trial') > 0
    AND SUM(activity_type = 'paid') > 0

ORDER BY user_id;
