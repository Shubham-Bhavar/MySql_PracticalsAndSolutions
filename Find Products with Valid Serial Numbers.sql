/*
============================================================
PROBLEM: Find Products with Valid Serial Numbers
============================================================

TABLE: products

+--------------+---------+--------------------------------+
| Column Name  | Type    | Description                    |
+--------------+---------+--------------------------------+
| product_id   | int     | Unique product ID              |
| product_name | varchar | Name of the product            |
| description  | varchar | Product description            |
+--------------+---------+--------------------------------+

TASK:
Find products whose description contains a valid serial number.

A valid serial number:

1. Starts with uppercase "SN" (case-sensitive).
2. Is followed by exactly 4 digits.
3. Contains a hyphen (-).
4. Is followed by exactly 4 digits.
5. Must not be part of a larger alphanumeric word or serial number.

VALID:
SN1234-5678

INVALID:
ASN1234-5678      -> "SN" is part of a larger word
sN4321-8765       -> "SN" must be uppercase
SN1234-56789      -> More than 4 digits after hyphen

============================================================
SOLUTION
============================================================
*/

SELECT
    product_id,
    product_name,
    description
FROM products
WHERE REGEXP_LIKE(
    description,
    '(^|[^[:alnum:]])SN[0-9]{4}-[0-9]{4}([^[:alnum:]]|$)',
    'c'
)
ORDER BY product_id;
