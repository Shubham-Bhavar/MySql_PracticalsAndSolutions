```sql
/*
LeetCode: Sales Analysis III

Problem:
Find products that were ONLY sold during the first quarter
of 2019, i.e. between 2019-01-01 and 2019-03-31.

Approach:
1. Join Product and Sales using product_id.
2. Group sales by product.
3. Find the earliest sale using MIN(sale_date).
4. Find the latest sale using MAX(sale_date).
5. If:
      MIN(sale_date) >= '2019-01-01'
   AND
      MAX(sale_date) <= '2019-03-31'
   then all sales of that product occurred in Q1 2019.

Example:
Product 1:
Sales -> 2019-01-21
MIN = 2019-01-21
MAX = 2019-01-21
Valid -> Include

Product 2:
Sales -> 2019-02-17, 2019-06-02
MAX = 2019-06-02
Not valid -> Exclude

Time Complexity:
O(n)

Space Complexity:
O(n)
*/

SELECT
    p.product_id,
    p.product_name
FROM Product p
JOIN Sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING
    MIN(s.sale_date) >= '2019-01-01'
    AND MAX(s.sale_date) <= '2019-03-31';
```
