/*
    LeetCode 185 - Department Top Three Salaries

    Problem:
    ----------
    Find employees whose salary is in the
    TOP 3 UNIQUE salaries of their department.

    Important:
    ----------
    "Unique salaries" means duplicate salaries
    should have the SAME rank.

    Example:

    IT salaries:
    90000 → Rank 1
    85000 → Rank 2
    85000 → Rank 2
    70000 → Rank 3

    Therefore, both employees earning 85000
    must be included.


    Approach:
    ----------
    1. JOIN Employee with Department
       to get the department name.

    2. Use DENSE_RANK() to rank salaries
       within each department.

    3. Keep only ranks 1, 2 and 3.


    Why DENSE_RANK()?
    -----------------
    RANK() would create gaps after duplicate salaries.

    Example:

        Salary     RANK
        90000       1
        85000       2
        85000       2
        70000       4   ← Problem!

    DENSE_RANK():

        Salary     DENSE_RANK
        90000          1
        85000          2
        85000          2
        70000          3   ← Correct!


    PARTITION BY department:
    -------------------------
    Each department gets its own ranking.

    ORDER BY salary DESC:
    ---------------------
    Highest salary gets rank 1.


    Time Complexity:
    ----------------
    O(n log n) approximately because of ranking/sorting.

    Space Complexity:
    -----------------
    Depends on the database execution plan.
*/

WITH ranked_employees AS
(
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,

        DENSE_RANK() OVER
        (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank

    FROM Employee e

    JOIN Department d
        ON e.departmentId = d.id
)

SELECT
    Department,
    Employee,
    Salary
FROM ranked_employees
WHERE salary_rank <= 3;
