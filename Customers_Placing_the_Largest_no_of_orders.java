/*
Question:
Find the customer_number of the customer who has placed
the largest number of orders.

It is guaranteed that exactly one customer has placed more
orders than every other customer.
*/

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;
