/*
LeetCode: Find Followers Count

Table: Followers

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+

(user_id, follower_id) is the primary key.

Task:
For each user, return the total number of followers.
Return the result ordered by user_id in ascending order.

Example:
user_id = 2 has followers {0, 1}
So, followers_count = 2.
*/

SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
