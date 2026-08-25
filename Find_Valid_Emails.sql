-- Question:
-- Find all valid email addresses.
--
-- Valid format:
-- 1. Exactly one @ symbol.
-- 2. Ends with .com.
-- 3. Username contains only letters, numbers, and underscores.
-- 4. Domain contains only letters.

SELECT
    user_id,
    email
FROM Users
WHERE email REGEXP '^[A-Za-z0-9_]+@[A-Za-z]+\\.com$'
ORDER BY user_id ASC;
