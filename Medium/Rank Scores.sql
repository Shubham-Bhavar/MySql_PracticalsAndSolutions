/*
LeetCode 178: Rank Scores

Table: Scores

+----+-------+
| id | score |
+----+-------+

Goal:
Rank scores from highest to lowest.

Rules:
1. Same scores get the same rank.
2. Ranks have no gaps.
3. Higher scores get smaller ranks.

DENSE_RANK() is used because:
4.00, 4.00, 3.85, 3.65
  1     1     2     3

*/

SELECT
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS `rank`
FROM Scores
ORDER BY score DESC;
