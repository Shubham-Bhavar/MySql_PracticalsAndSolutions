/*
    LeetCode 3626 - Find Stores with Inventory Imbalance

    Problem:
    --------
    Find stores where:

    1. The store has at least 3 different products.
    2. The most expensive product has lower stock than
       the cheapest product.
    3. Calculate imbalance_ratio as:

       cheapest_quantity / most_expensive_quantity

    4. Round the imbalance ratio to 2 decimal places.

    Return:
    store_id,
    store_name,
    location,
    most_exp_product,
    cheapest_product,
    imbalance_ratio

    Order by imbalance_ratio DESC, then store_name ASC.
*/

WITH product_count AS
(
    SELECT
        store_id,
        COUNT(DISTINCT product_name) AS total_products
    FROM inventory
    GROUP BY store_id
),

ranked_inventory AS
(
    SELECT
        inventory_id,
        store_id,
        product_name,
        quantity,
        price,

        ROW_NUMBER() OVER (
            PARTITION BY store_id
            ORDER BY price DESC, inventory_id
        ) AS expensive_rank,

        ROW_NUMBER() OVER (
            PARTITION BY store_id
            ORDER BY price ASC, inventory_id
        ) AS cheap_rank

    FROM inventory
)

SELECT
    s.store_id,
    s.store_name,
    s.location,
    expensive.product_name AS most_exp_product,
    cheap.product_name AS cheapest_product,
    ROUND(
        cheap.quantity / expensive.quantity,
        2
    ) AS imbalance_ratio

FROM stores s

JOIN product_count pc
    ON s.store_id = pc.store_id

JOIN ranked_inventory expensive
    ON s.store_id = expensive.store_id
   AND expensive.expensive_rank = 1

JOIN ranked_inventory cheap
    ON s.store_id = cheap.store_id
   AND cheap.cheap_rank = 1

WHERE pc.total_products >= 3
  AND expensive.quantity < cheap.quantity

ORDER BY
    imbalance_ratio DESC,
    s.store_name ASC;
