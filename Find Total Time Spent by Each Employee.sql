/*
Question: Find Total Time Spent by Each Employee

Calculate the total time spent by each employee
on each day in the office.

Time spent for one event = out_time - in_time
*/

SELECT
    event_day AS day,
    emp_id,
    SUM(out_time - in_time) AS total_time
FROM Employees
GROUP BY
    event_day,
    emp_id;
