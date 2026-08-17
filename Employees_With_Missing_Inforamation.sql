-- Table: Employees
-- +-------------+---------+
-- | employee_id | name    |
-- +-------------+---------+
-- | 2           | Crew    |
-- | 4           | Haven   |
-- | 5           | Kristian|
-- +-------------+---------+

-- Table: Salaries
-- +-------------+--------+
-- | employee_id | salary |
-- +-------------+--------+
-- | 5           | 76071  |
-- | 1           | 22517  |
-- | 4           | 63539  |
-- +-------------+--------+

-- Find employees whose name OR salary is missing.

SELECT e.employee_id
FROM Employees e
LEFT JOIN Salaries s
ON e.employee_id = s.employee_id
WHERE s.employee_id IS NULL

UNION

SELECT s.employee_id
FROM Salaries s
LEFT JOIN Employees e
ON s.employee_id = e.employee_id
WHERE e.employee_id IS NULL

ORDER BY employee_id;
