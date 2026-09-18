/*
LeetCode 3482. Analyze Organization Hierarchy

Difficulty: Hard

Problem Statement:
For each employee, find:

1. level:
   CEO is level 1.
   Employees directly under CEO are level 2, and so on.

2. team_size:
   Total number of employees under that employee,
   including direct and indirect reports.

3. budget:
   Employee's own salary + salaries of all employees
   under them.

Return:
employee_id, employee_name, level, team_size, budget

Order:
1. level ASC
2. budget DESC
3. employee_name ASC

Approach:
Use a Recursive CTE.

The recursive CTE starts from the CEO and moves
down through the organization.

Then for every employee, calculate:
- number of employees below them
- total salary of employees below them
- add their own salary to get the budget
*/

WITH RECURSIVE hierarchy AS (

    -- Start with the CEO
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level,
        employee_id AS manager_root
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Find employees under each manager
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        h.level + 1,
        h.manager_root
    FROM Employees e
    JOIN hierarchy h
        ON e.manager_id = h.employee_id
),

team_data AS (

    SELECT
        m.employee_id,
        COUNT(e.employee_id) AS team_size,
        COALESCE(SUM(e.salary), 0) AS team_salary
    FROM Employees m
    LEFT JOIN hierarchy e
        ON e.manager_id = m.employee_id
    GROUP BY m.employee_id
)

SELECT
    h.employee_id,
    h.employee_name,
    h.level,
    COUNT(t.employee_id) AS team_size,
    h.salary + COALESCE(SUM(t.salary), 0) AS budget
FROM hierarchy h
LEFT JOIN hierarchy t
    ON t.manager_id = h.employee_id
GROUP BY
    h.employee_id,
    h.employee_name,
    h.level,
    h.salary
ORDER BY
    h.level ASC,
    budget DESC,
    h.employee_name ASC;