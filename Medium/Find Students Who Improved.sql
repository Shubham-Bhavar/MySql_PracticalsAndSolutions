/*
    LeetCode 3421 - Find Students Who Improved

    Problem:
    Find students who have improved their score in a subject.

    Conditions:
    1. Student must have taken the same subject on at least
       two different dates.
    2. Latest score must be greater than the first score.

    Return:
        student_id
        subject
        first_score
        latest_score

    Order by:
        student_id ASC
        subject ASC

    --------------------------------------------------

    Approach:
    1. Group by student and subject.
    2. Find the first score using FIRST_VALUE().
    3. Find the latest score using LAST_VALUE().
    4. Count the number of exams.
    5. Keep only students whose latest score > first score
       and have at least 2 exams.

    --------------------------------------------------

    Time Complexity:
    O(n log n)

    Space Complexity:
    O(n)
*/

WITH scores_data AS
(
    SELECT
        student_id,
        subject,

        FIRST_VALUE(score) OVER (
            PARTITION BY student_id, subject
            ORDER BY exam_date
        ) AS first_score,

        LAST_VALUE(score) OVER (
            PARTITION BY student_id, subject
            ORDER BY exam_date
            ROWS BETWEEN UNBOUNDED PRECEDING
                     AND UNBOUNDED FOLLOWING
        ) AS latest_score,

        COUNT(*) OVER (
            PARTITION BY student_id, subject
        ) AS exam_count

    FROM Scores
)

SELECT DISTINCT
    student_id,
    subject,
    first_score,
    latest_score
FROM scores_data
WHERE exam_count >= 2
  AND latest_score > first_score
ORDER BY
    student_id ASC,
    subject ASC;
