/*
===========================================================
LeetCode 1393 - Capital Gain/Loss
===========================================================

PROBLEM:
Find the total capital gain or loss for each stock.

For every stock:
    Sell price  -> positive
    Buy price   -> negative

Capital Gain/Loss =
    SUM(Sell prices) - SUM(Buy prices)

-----------------------------------------------------------
TABLE: Stocks
-----------------------------------------------------------

| Column Name   | Type    | Description                    |
|---------------|---------|--------------------------------|
| stock_name    | varchar | Name of the stock              |
| operation     | enum    | 'Buy' or 'Sell'                |
| operation_day | int     | Day of the operation           |
| price         | int     | Price of the operation         |

Primary Key:
    (stock_name, operation_day)

-----------------------------------------------------------
EXAMPLE:
-----------------------------------------------------------

Corona Masks:

Buy  = 10
Sell = 1010
Buy  = 1000
Sell = 500
Buy  = 1000
Sell = 10000

Capital Gain/Loss:

(1010 - 10)
+ (500 - 1000)
+ (10000 - 1000)

= 1000 - 500 + 9000
= 9500

-----------------------------------------------------------
LOGIC:
-----------------------------------------------------------

1. Use CASE to convert operations into values:

   If operation = 'Buy'
       price becomes -price

   If operation = 'Sell'
       price remains +price

2. GROUP BY stock_name

3. Use SUM() to calculate total gain/loss.

-----------------------------------------------------------
SQL FUNCTIONS USED:
-----------------------------------------------------------

CASE
    -> Checks whether the operation is Buy or Sell.

SUM()
    -> Calculates the total gain/loss.

GROUP BY
    -> Calculates the result separately for each stock.

===========================================================
SOLUTION
===========================================================
*/

SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = 'Buy' THEN -price
            ELSE price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;

