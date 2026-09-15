/*
    LeetCode 3611 - Find Overbooked Employees

    Problem:
    Find employees who spend more than 50% of their working
    time in meetings during a week.

    Standard work week = 40 hours
    50% of 40 hours = 20 hours

    An employee is meeting-heavy when:
        Weekly meeting hours > 20

    Conditions:
        - Calculate meeting hours per employee per week.
        - Week is Monday to Sunday.
        - Count meeting-heavy weeks.
        - Include employees with at least 2 heavy weeks.

    Order:
        1. meeting_heavy_weeks DESC
        2. employee_name ASC

    --------------------------------------------------

    Approach:
    1. Use YEARWEEK() to group meetings by week.
    2. SUM() the meeting duration.
    3. Keep weeks having more than 20 hours.
    4. Count heavy weeks for each employee.
    5. Join with employees table.

    --------------------------------------------------

    Time Complexity:
    O(n)

    Space Complexity:
    O(n)
*/

WITH weekly_hours AS
(
    SELECT
        employee_id,

        YEARWEEK(meeting_date, 1) AS week_number,

        SUM(duration_hours) AS total_hours

    FROM meetings

    GROUP BY
        employee_id,
        YEARWEEK(meeting_date, 1)
),

heavy_weeks AS
(
    SELECT
        employee_id,
        COUNT(*) AS meeting_heavy_weeks

    FROM weekly_hours

    WHERE total_hours > 20

    GROUP BY employee_id

    HAVING COUNT(*) >= 2
)

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    h.meeting_heavy_weeks

FROM employees e
JOIN heavy_weeks h
    ON e.employee_id = h.employee_id

ORDER BY
    h.meeting_heavy_weeks DESC,
    e.employee_name ASC;
