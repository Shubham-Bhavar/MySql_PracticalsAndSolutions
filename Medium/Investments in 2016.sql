/*
LeetCode 585 - Investments in 2016

Problem:
Find the sum of tiv_2016 for policyholders who:

1. Have the same tiv_2015 value as at least one other policyholder.
2. Have a unique (lat, lon) location.

Approach:
- GROUP BY tiv_2015 and keep values having COUNT(*) > 1.
- GROUP BY (lat, lon) and keep locations having COUNT(*) = 1.
- Select only records satisfying both conditions.
- Sum tiv_2016 and round to 2 decimal places.

Example:
tiv_2015 = 10 appears multiple times.
Unique locations:
(10,10) and (40,40)

Their tiv_2016 values:
5 + 40 = 45

Output:
45.00
*/

SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN
(
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN
(
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);
