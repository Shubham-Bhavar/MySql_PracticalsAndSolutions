/*
LeetCode 176 - Second Highest Salary

Problem:
Find the second highest DISTINCT salary from the Employee table.

If there is no second highest salary, return NULL.

Example 1:
Employee:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

Output:
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

Example 2:
Employee:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+

Output:
NULL


Approach:
1. Select DISTINCT salaries.
2. Sort salaries in descending order.
3. Skip the highest salary using OFFSET 1.
4. LIMIT 1 returns the second highest salary.
5. If it does not exist, the subquery returns NULL.
*/

SELECT
    (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET 1
    ) AS SecondHighestSalary;
