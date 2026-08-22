/*
LeetCode: Delete Duplicate Emails

Task:
Delete duplicate emails and keep only the row
with the smallest id.

Example:

Before:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+

Since IDs 1 and 3 have the same email,
keep the smaller ID (1) and delete ID 3.
*/

DELETE p1
FROM Person p1
JOIN Person p2
    ON p1.email = p2.email
    AND p1.id > p2.id;
