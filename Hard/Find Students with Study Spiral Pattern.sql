```sql
/*
===============================================================================
LeetCode 3617: Find Students with Study Spiral Pattern
Difficulty: Hard
SQL
===============================================================================

Problem:
--------

Find students who follow a "Study Spiral Pattern" — studying at least
3 different subjects in a repeating sequence.

A student qualifies if:

1. They study at least 3 different subjects.
2. The subject sequence repeats for at least 2 complete cycles.
3. There are no gaps longer than 2 days between consecutive sessions.
4. The total number of sessions is exactly divisible by the cycle length.
5. Every repeated cycle follows the same subject sequence.

Return:
-------
- student_id
- student_name
- major
- cycle_length
- total_study_hours

Order the result by:
1. cycle_length DESC
2. total_study_hours DESC


===============================================================================
Table: students
===============================================================================

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| student_name | varchar |
| major        | varchar |
+--------------+---------+

student_id is the unique identifier for this table.
Each row contains information about a student and their academic major.


===============================================================================
Table: study_sessions
===============================================================================

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| session_id    | int     |
| student_id    | int     |
| subject       | varchar |
| session_date  | date    |
| hours_studied | decimal |
+---------------+---------+

session_id is the unique identifier for this table.
Each row represents a study session by a student for a specific subject.


===============================================================================
Example
===============================================================================

Student 1:

Math → Physics → Chemistry → Math → Physics → Chemistry

cycle_length = 3
complete_cycles = 2
total_sessions = 6
total_hours = 15.0


Student 2:

Algebra → Calculus → Statistics → Geometry
→ Algebra → Calculus → Statistics → Geometry

cycle_length = 4
complete_cycles = 2
total_sessions = 8
total_hours = 26.0


===============================================================================
Approach
===============================================================================

Step 1: ordered
----------------
Use ROW_NUMBER() to assign a sequential position to every study session
for each student.

LAG() is used to find the previous session date.

Example:

Math       → rn 1
Physics    → rn 2
Chemistry  → rn 3
Math       → rn 4
Physics    → rn 5
Chemistry  → rn 6


Step 2: student_stats
---------------------
Calculate important statistics for every student:

- total_n       → total number of study sessions
- cycle_len     → number of different subjects
- total_hours   → total study hours
- has_big_gap   → checks whether any consecutive sessions have a gap
                   greater than 2 days


Step 3: pattern_check
---------------------
Compare every session after the first cycle with the session located
exactly one cycle length earlier.

For cycle length = 3:

Position 4 → compare with Position 1
Position 5 → compare with Position 2
Position 6 → compare with Position 3

If any subject does not match, the repeating pattern is invalid.


Step 4: Final filtering
-----------------------
Keep only students who satisfy all conditions:

- cycle_len >= 3
- total_n >= 2 * cycle_len
- total_n % cycle_len = 0
- no gap greater than 2 days
- no subject mismatch between cycles


===============================================================================
Solution
===============================================================================
*/

WITH ordered AS (
    SELECT
        student_id,
        subject,
        session_date,
        hours_studied,

        ROW_NUMBER() OVER (
            PARTITION BY student_id
            ORDER BY session_date, session_id
        ) AS rn,

        LAG(session_date) OVER (
            PARTITION BY student_id
            ORDER BY session_date, session_id
        ) AS prev_date

    FROM study_sessions
),

student_stats AS (
    SELECT
        student_id,

        COUNT(*) AS total_n,

        COUNT(DISTINCT subject) AS cycle_len,

        SUM(hours_studied) AS total_hours,

        MAX(
            CASE
                WHEN prev_date IS NOT NULL
                     AND DATEDIFF(session_date, prev_date) > 2
                THEN 1
                ELSE 0
            END
        ) AS has_big_gap

    FROM ordered
    GROUP BY student_id
),

pattern_check AS (
    SELECT
        o1.student_id,

        MAX(
            CASE
                WHEN o2.subject IS NULL
                     OR o2.subject <> o1.subject
                THEN 1
                ELSE 0
            END
        ) AS mismatch

    FROM ordered o1

    JOIN student_stats s
        ON s.student_id = o1.student_id
       AND o1.rn > s.cycle_len

    LEFT JOIN ordered o2
        ON o2.student_id = o1.student_id
       AND o2.rn = o1.rn - s.cycle_len

    GROUP BY o1.student_id
)

SELECT
    st.student_id,
    st.student_name,
    st.major,
    ss.cycle_len AS cycle_length,
    ss.total_hours AS total_study_hours

FROM student_stats ss

JOIN students st
    ON st.student_id = ss.student_id

LEFT JOIN pattern_check pc
    ON pc.student_id = ss.student_id

WHERE ss.cycle_len >= 3
  AND ss.total_n >= 2 * ss.cycle_len
  AND ss.total_n % ss.cycle_len = 0
  AND ss.has_big_gap = 0
  AND COALESCE(pc.mismatch, 0) = 0

ORDER BY
    cycle_length DESC,
    total_study_hours DESC;


/*
===============================================================================
Complexity
===============================================================================

Time Complexity:
O(N log N)

Space Complexity:
O(N)

Where N = number of rows in study_sessions.


===============================================================================
Key SQL Concepts Used
===============================================================================

1. ROW_NUMBER()
   → Assigns sequential positions to sessions.

2. LAG()
   → Gets the previous session date.

3. COUNT(DISTINCT)
   → Finds the number of unique subjects.

4. DATEDIFF()
   → Checks the gap between consecutive sessions.

5. CASE
   → Performs conditional checks.

6. CTEs (WITH)
   → Breaks the complex problem into smaller logical steps.

7. Window Functions
   → Used to analyze the ordered study-session sequence.
===============================================================================
```
