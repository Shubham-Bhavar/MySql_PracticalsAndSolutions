```sql
/*
========================================================
LeetCode 177 - Nth Highest Salary
========================================================

Problem:
--------
Find the nth highest DISTINCT salary from the Employee
table.

If there are fewer than n distinct salaries, return NULL.

Table: Employee
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

Example:
--------
N = 2

Output:
-------
200

--------------------------------------------------------
Approach:
--------------------------------------------------------

1. For every salary, count how many DISTINCT salaries
   are greater than it.

2. For the nth highest salary, exactly (N - 1) distinct
   salaries must be greater than it.

3. Use MAX() to return that salary.

4. If no such salary exists, MAX() returns NULL.

--------------------------------------------------------
Example for N = 2:
--------------------------------------------------------

Salaries:

300
200
100

For salary 200:
- Greater salaries = 300
- COUNT(DISTINCT) = 1
- N - 1 = 2 - 1 = 1

Therefore, 200 is the 2nd highest salary.

--------------------------------------------------------
Complexity:
--------------------------------------------------------

Time Complexity  : O(n²) in the straightforward execution
Space Complexity : O(1) extra space

========================================================
*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN

    RETURN (
        SELECT MAX(e1.salary)
        FROM Employee e1
        WHERE N - 1 =
        (
            SELECT COUNT(DISTINCT e2.salary)
            FROM Employee e2
            WHERE e2.salary > e1.salary
        )
    );

END
```
