/*
    LeetCode 1731 - The Number of Employees Which Report to Each Employee

    Problem:
    ----------
    Find all managers and report:
    1. employee_id
    2. name
    3. number of employees reporting directly to them
    4. average age of their direct reports

    The average age should be rounded to the nearest integer.


    Approach:
    ----------
    We use a SELF JOIN.

    Employees table:

    Manager:
        employee_id = 9
        name = Hercy

    Reports:
        employee_id = 6 → reports_to = 9
        employee_id = 4 → reports_to = 9


    JOIN condition:

        manager.employee_id = employee.reports_to


    This connects each manager with their direct reports.


    Example:

        Manager     Report
        Hercy   →   Alice
        Hercy   →   Bob

    Then:

        COUNT(report.employee_id)
        = 2

        AVG(report.age)
        = (41 + 36) / 2
        = 38.5

        ROUND(38.5)
        = 39


    Important:
    ----------
    We use COUNT(report.employee_id), not COUNT(*),
    because we only want the employees who report
    to the manager.


    GROUP BY:
    ----------
    We group by manager's ID and name so that
    each manager gets one result row.


    Time Complexity:
    ----------------
    O(n)

    Space Complexity:
    -----------------
    O(n) depending on the database execution plan.
*/

SELECT
    manager.employee_id,
    manager.name,
    COUNT(employee.employee_id) AS reports_count,
    ROUND(AVG(employee.age)) AS average_age

FROM Employees AS manager

JOIN Employees AS employee
    ON manager.employee_id = employee.reports_to

GROUP BY
    manager.employee_id,
    manager.name

ORDER BY
    manager.employee_id;
