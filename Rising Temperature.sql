```sql
/*
========================================================
LeetCode 197 - Rising Temperature
========================================================

Problem:
--------
Find the IDs of dates where the temperature is higher
than the previous day.

Table: Weather
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Output:
-------
2
4

Explanation:
------------
2015-01-02: 25 > 10  -> Rising
2015-01-03: 20 < 25  -> Not Rising
2015-01-04: 30 > 20  -> Rising

--------------------------------------------------------
Approach:
--------------------------------------------------------

1. Join the Weather table with itself.
2. Match today's date with yesterday's date.
3. Check whether today's temperature is greater
   than yesterday's temperature.
4. Return today's ID.

DATE_SUB(recordDate, INTERVAL 1 DAY)
gives yesterday's date.

========================================================
*/

SELECT
    today.id
FROM Weather today
JOIN Weather yesterday
    ON today.recordDate = DATE_ADD(yesterday.recordDate, INTERVAL 1 DAY)
WHERE today.temperature > yesterday.temperature;
```
