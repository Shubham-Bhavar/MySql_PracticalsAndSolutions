/*
Question:
Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+

(student, class) is the primary key.
Each row represents a student enrolled in a class.

Write a solution to find all the classes that have at least five students.

Example:
Courses:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+

Output:
+-------+
| class |
+-------+
| Math  |
+-------+
*/

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
