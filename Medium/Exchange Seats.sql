/*
===========================================================
LeetCode 626 - Exchange Seats
===========================================================

PROBLEM:
Swap the seat ID of every two consecutive students.

If the number of students is odd, the last student's
seat should remain unchanged.

-----------------------------------------------------------
TABLE: Seat
-----------------------------------------------------------

| Column Name | Type    | Description              |
|-------------|---------|--------------------------|
| id          | int     | Unique seat ID           |
| student     | varchar | Name of the student      |

Primary Key:
    id

The IDs start from 1 and increase continuously.

-----------------------------------------------------------
EXAMPLE:
-----------------------------------------------------------

Input:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+

Output:
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+

-----------------------------------------------------------
LOGIC:
-----------------------------------------------------------

1. If id is odd:
       id = id + 1

2. If id is even:
       id = id - 1

3. If the last id is odd:
       Keep the id unchanged.

Example:
    1 ↔ 2
    3 ↔ 4
    5 → 5

-----------------------------------------------------------
SQL FUNCTIONS USED:
-----------------------------------------------------------

id % 2
    -> Checks whether id is odd or even.

MAX(id)
    -> Finds the last student ID.

CASE
    -> Applies different conditions.

ORDER BY
    -> Sorts the final result by id.

-----------------------------------------------------------
SOLUTION:
-----------------------------------------------------------
*/

SELECT
    CASE
        WHEN id % 2 = 1
             AND id = (SELECT MAX(id) FROM Seat)
        THEN id

        WHEN id % 2 = 1
        THEN id + 1

        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;
```
