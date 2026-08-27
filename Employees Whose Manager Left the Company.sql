/*
============================================================
PROBLEM: Employees Whose Manager Left the Company
============================================================

TABLE: Employees

+-------------+----------+------------+--------+
| Column Name | Type     | Description            |
+-------------+----------+------------+--------+
| employee_id | int      | Unique employee ID     |
| name        | varchar  | Employee name          |
| manager_id  | int      | Manager's employee ID  |
| salary      | int      | Employee salary        |
+-------------+----------+------------+--------+

employee_id is the primary key.
Some employees do not have a manager, so manager_id can be NULL.

TASK:
Find the employee IDs of employees who:

1. Have a salary strictly less than 30000.
2. Have a manager (manager_id is NOT NULL).
3. Their manager has left the company.

When a manager leaves the company, their information is
deleted from the Employees table, but their employees still
have the old manager_id.

Return the result ordered by employee_id in ascending order.

------------------------------------------------------------
EXAMPLE
------------------------------------------------------------

Employees:

+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | NULL       | 31000  |
| 13          | Emery     | NULL       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | NULL       | 50937  |
| 11          | Joziah    | 6          | 28485  |
+-------------+-----------+------------+--------+

OUTPUT:

+-------------+
| employee_id |
+-------------+
| 11          |
+-------------+

EXPLANATION:

- Employee 1 has salary 21241, which is less than 30000.
  However, manager 11 still exists in the Employees table.

- Employee 11 has salary 28485, which is less than 30000.
  Employee 11 has manager_id = 6, but employee 6 does not
  exist in the Employees table.

Therefore, employee 11 is selected.

============================================================
SOLUTION
============================================================
*/

SELECT employee_id
FROM Employees
WHERE salary < 30000
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
      SELECT employee_id
      FROM Employees
  )
ORDER BY employee_id;
