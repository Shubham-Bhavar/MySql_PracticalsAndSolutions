/*
LeetCode: Primary Department for Each Employee

Task:
1. If an employee has multiple departments,
   return the department where primary_flag = 'Y'.

2. If an employee belongs to only one department,
   return that department even if primary_flag = 'N'.
*/

SELECT
    employee_id,
    department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
       SELECT employee_id
       FROM Employee
       GROUP BY employee_id
       HAVING COUNT(*) = 1
   );
