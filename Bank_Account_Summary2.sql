/*
Question:
Find the name and balance of users whose balance
is greater than 10000.

Table: Users
+---------+---------+
| account | name    |
+---------+---------+
| int     | varchar |
+---------+---------+

Table: Transactions
+---------------+---------+
| trans_id      | int     |
| account       | int     |
| amount        | int     |
| transacted_on | date    |
+---------------+---------+

Balance of an account = SUM of all transaction amounts.

Example:
Alice: 7000 + 7000 - 3000 = 11000
Bob: 1000
Charlie: 6000 + 6000 - 4000 = 8000

Output:
+-------+---------+
| name  | balance |
+-------+---------+
| Alice | 11000   |
+-------+---------+
*/

SELECT
    Users.name,
    SUM(Transactions.amount) AS balance
FROM Users
JOIN Transactions
    ON Users.account = Transactions.account
GROUP BY Users.account, Users.name
HAVING SUM(Transactions.amount) > 10000;
