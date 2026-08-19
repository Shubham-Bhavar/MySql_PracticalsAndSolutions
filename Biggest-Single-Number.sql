/*
LeetCode: Biggest Single Number

Table: MyNumbers
+-------------+
| Column Name |
+-------------+
| num         |
+-------------+

Problem:
Find the largest number that appears only once.
If there is no single number, return NULL.

Example:
Input:
8
8
3
3
1
4
5
6

Single numbers = 1, 4, 5, 6
Largest single number = 6
*/

SELECT MAX(num) AS num
FROM MyNumbers
WHERE num IN (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
);
