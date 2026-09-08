/*
LeetCode 180 - Consecutive Numbers

Problem:
Find all numbers that appear at least three times consecutively.

The id column is sequential, so we can compare:
    current id
    next id
    next-next id

Example:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
+----+-----+

Output:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

Approach:
1. Join Logs three times.
2. Compare three consecutive ids.
3. Check whether their num values are the same.
4. DISTINCT avoids duplicate results.
*/

SELECT DISTINCT
    l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2
    ON l2.id = l1.id + 1
JOIN Logs l3
    ON l3.id = l1.id + 2
WHERE l1.num = l2.num
  AND l2.num = l3.num;
