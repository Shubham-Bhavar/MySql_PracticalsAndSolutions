/*
LeetCode: Actors and Directors Who Cooperated At Least Three Times

Table: ActorDirector
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+

Problem:
Find all (actor_id, director_id) pairs where the actor
has cooperated with the director at least 3 times.

Example:
Input:
actor_id | director_id | timestamp
---------|-------------|----------
1        | 1           | 0
1        | 1           | 1
1        | 1           | 2
1        | 2           | 3
1        | 2           | 4

Output:
actor_id | director_id
---------|------------
1        | 1
*/

SELECT
    actor_id,
    director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;
