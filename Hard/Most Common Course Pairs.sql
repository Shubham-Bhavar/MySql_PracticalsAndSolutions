/*
    LeetCode 3764 - Most Common Course Pairs

    Problem:
    --------
    Identify the most common consecutive course pairs among
    top-performing students.

    A top-performing student:
    - Completed at least 5 courses.
    - Has an average course rating of at least 4.

    For each top-performing student:
    - Order courses by completion_date.
    - Find every consecutive course pair.

    Return:
    - first_course
    - second_course
    - transition_count

    Order by:
    1. transition_count DESC
    2. first_course ASC
    3. second_course ASC
*/

WITH top_students AS
(
    SELECT
        user_id
    FROM course_completions
    GROUP BY user_id
    HAVING COUNT(*) >= 5
       AND AVG(course_rating) >= 4
),
ordered_courses AS
(
    SELECT
        user_id,
        course_name,
        LEAD(course_name) OVER (
            PARTITION BY user_id
            ORDER BY completion_date
        ) AS next_course
    FROM course_completions
    WHERE user_id IN (
        SELECT user_id
        FROM top_students
    )
)
SELECT
    course_name AS first_course,
    next_course AS second_course,
    COUNT(*) AS transition_count
FROM ordered_courses
WHERE next_course IS NOT NULL
GROUP BY course_name, next_course
ORDER BY
    transition_count DESC,
    first_course ASC,
    second_course ASC;
