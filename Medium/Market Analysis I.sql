/*
===========================================================
LeetCode 1158 - Market Analysis I
===========================================================

Problem:
For every user, find:
1. Their user_id
2. Their join_date
3. Number of orders they made as a buyer in 2019

Important:
Users who made no orders in 2019 must also be included
with orders_in_2019 = 0.

-----------------------------------------------------------
Approach:
-----------------------------------------------------------

1. Start with Users table because every user is required.
2. LEFT JOIN Orders using:
       Users.user_id = Orders.buyer_id

3. Put the 2019 condition inside the JOIN condition.
   This is important because putting it in WHERE would remove
   users who have no 2019 orders.

4. COUNT(o.order_id) counts only the matching 2019 orders.

-----------------------------------------------------------
*/

SELECT
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019

FROM Users u

LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
    AND YEAR(o.order_date) = 2019

GROUP BY
    u.user_id,
    u.join_date;
