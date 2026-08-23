/*
 * LeetCode 610: Triangle Judgement
 *
 * Given three line segments with lengths x, y, and z,
 * determine whether they can form a triangle.
 *
 * Triangle Rule:
 * The sum of any two sides must be greater than the third side.
 *
 * Conditions:
 * x + y > z
 * x + z > y
 * y + z > x
 *
 * If all three conditions are true, return 'Yes'.
 * Otherwise, return 'No'.
 *
 * Example:
 * x = 13, y = 15, z = 30
 *
 * 13 + 15 = 28, which is not greater than 30.
 * Therefore, they cannot form a triangle.
 *
 * Output: No
 *
 * Approach:
 * 1. Check all three triangle inequality conditions.
 * 2. Use CASE to return 'Yes' if all conditions are true.
 * 3. Otherwise, return 'No'.
 *
 * Time Complexity: O(n)
 * Space Complexity: O(1)
 */

SELECT
    x,
    y,
    z,
    CASE
        WHEN x + y > z
         AND x + z > y
         AND y + z > x
        THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle;
