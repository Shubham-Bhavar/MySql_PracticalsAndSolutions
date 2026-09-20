/*
    LeetCode 601 - Human Traffic of Stadium

    Problem:
    --------
    Find all Stadium records where there are at least
    3 consecutive IDs and every record has people >= 100.

    Consecutive means consecutive IDs, not consecutive dates.

    Return:
    - id
    - visit_date
    - people

    Order by visit_date in ascending order.

    Approach:
    ---------
    Use a self-join to find the previous two consecutive IDs.

    For every row:
        current id
        previous id = id - 1
        previous previous id = id - 2

    If all three rows have people >= 100,
    then the current row belongs to a valid group.

    We also check forward IDs so that all rows in a group
    are included.

    DISTINCT removes duplicate rows caused by multiple
    matching combinations.
*/

SELECT DISTINCT s1.*
FROM Stadium s1
JOIN Stadium s2
    ON s2.id = s1.id - 1
JOIN Stadium s3
    ON s3.id = s1.id - 2
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100

UNION

SELECT DISTINCT s1.*
FROM Stadium s1
JOIN Stadium s2
    ON s2.id = s1.id + 1
JOIN Stadium s3
    ON s3.id = s1.id + 2
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100

UNION

SELECT DISTINCT s1.*
FROM Stadium s1
JOIN Stadium s2
    ON s2.id = s1.id - 1
JOIN Stadium s3
    ON s3.id = s1.id + 1
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100

ORDER BY visit_date ASC;
