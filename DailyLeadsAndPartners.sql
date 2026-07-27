-- Problem: Count Unique Leads and Partners
-- Platform: LeetCode

/*
Table: DailySales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| date_id     | date    |
| make_name   | varchar |
| lead_id     | int     |
| partner_id  | int     |
+-------------+---------+

Task:
For each date_id and make_name, find:
- Number of distinct lead_id → unique_leads
- Number of distinct partner_id → unique_partners
*/

SELECT 
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM DailySales
GROUP BY date_id, make_name;
