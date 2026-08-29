/*
LeetCode: Average Selling Price

Problem:
Find the average selling price for each product.

Average Selling Price:
Total selling amount / Total units sold

Total selling amount = price * units

If a product has no sold units, its average price is 0.

Approach:
1. Start with Prices table.
2. Use LEFT JOIN with UnitsSold so that products
   with no sales are also included.
3. Match the product_id.
4. Match purchase_date between start_date and end_date.
5. Calculate total selling amount using price * units.
6. Divide total selling amount by total units.
7. Use COALESCE to return 0 when there are no sales.
8. ROUND the result to 2 decimal places.
9. GROUP BY product_id.

Example:
Product 1:
(100 * 5) + (15 * 20) = 800

Total units = 100 + 15 = 115

Average price = 800 / 115 = 6.96

Time Complexity: O(P + U)
Space Complexity: O(P)
*/

SELECT 
    p.product_id,

    ROUND(
        COALESCE(
            SUM(p.price * u.units) / SUM(u.units),
            0
        ),
        2
    ) AS average_price

FROM Prices p

LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date

GROUP BY p.product_id;
