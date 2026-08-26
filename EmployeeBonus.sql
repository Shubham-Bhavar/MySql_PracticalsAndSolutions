/*
577. Employee Bonus

Find employees whose bonus is less than 1000
or who do not have a bonus.
*/

SELECT name, bonus
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId
WHERE bonus < 1000
   OR bonus IS NULL;
