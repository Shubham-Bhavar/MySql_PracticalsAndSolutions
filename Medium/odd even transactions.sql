/*
===========================================================
Table: transactions
===========================================================

Columns:
transaction_id   -> Unique transaction ID
amount           -> Transaction amount
transaction_date -> Transaction date

Task:
Find the sum of amounts for ODD and EVEN amounts
for each transaction date.

Odd amount  -> amount % 2 = 1
Even amount -> amount % 2 = 0

===========================================================
*/

SELECT
    transaction_date,

    SUM(
        CASE
            WHEN amount % 2 = 1 THEN amount
            ELSE 0
        END
    ) AS odd_sum,

    SUM(
        CASE
            WHEN amount % 2 = 0 THEN amount
            ELSE 0
        END
    ) AS even_sum

FROM transactions

GROUP BY transaction_date

ORDER BY transaction_date ASC;
