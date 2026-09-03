/*
LeetCode 184 - Department Highest Salary

Approach:
1. Join Employee and Department using departmentId.
2. Find the maximum salary for each department.
3. Return all employees whose salary equals
   the maximum salary of their department.

Important:
If multiple employees have the same highest salary,
return all of them.
*/

SELECT
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM Employee e2
    WHERE e2.departmentId = e.departmentId
);
