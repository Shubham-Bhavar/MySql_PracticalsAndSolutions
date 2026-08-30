/*
LeetCode: 1280. Students and Examinations

Problem:
Find how many times each student attended each subject exam.

Approach:
1. Use CROSS JOIN between Students and Subjects
   to create every student-subject combination.
2. Use LEFT JOIN with Examinations so that students
   with no exam attendance are also included.
3. COUNT() the matching exam records.
4. GROUP BY student and subject.
5. Sort by student_id and subject_name.

Time Complexity: O(S × Sub + E)
Space Complexity: O(S × Sub)
*/

SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams

FROM Students s

CROSS JOIN Subjects sub

LEFT JOIN Examinations e
    ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name

GROUP BY
    s.student_id,
    s.student_name,
    sub.subject_name

ORDER BY
    s.student_id,
    sub.subject_name;
