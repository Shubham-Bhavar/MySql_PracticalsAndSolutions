/*
LeetCode 1907 - Count Salary Categories

Table: Accounts
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+

Salary Categories:
1. Low Salary     -> income < 20000
2. Average Salary -> income >= 20000 AND income <= 50000
3. High Salary    -> income > 50000

Approach:
Use UNION ALL to create all 3 categories.
For each category, count the accounts using COUNT().
*/

SELECT 'Low Salary' AS category,
       COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM Accounts

UNION ALL

SELECT 'Average Salary',
       COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END)
FROM Accounts

UNION ALL

SELECT 'High Salary',
       COUNT(CASE WHEN income > 50000 THEN 1 END)
FROM Accounts;
