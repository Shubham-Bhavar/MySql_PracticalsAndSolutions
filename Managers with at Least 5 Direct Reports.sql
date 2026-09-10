/*
LeetCode 570 - Managers with at Least 5 Direct Reports

Problem:
Find the managers who have at least 5 direct reports.

Approach:
1. Group employees by managerId.
2. Count how many employees report to each manager.
3. Keep managers having count >= 5.
4. Join with Employee to get the manager's name.

*/

SELECT e.name
FROM Employee e
JOIN
(
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m
ON e.id = m.managerId;
