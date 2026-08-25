/*
Question:
Find users who have valid e-mail addresses.

Rules:
1. The prefix must start with a letter.
2. The prefix may contain letters, digits, _, . and -.
3. The domain must be exactly @leetcode.com in lowercase.
*/

SELECT
    user_id,
    name,
    mail
FROM Users
WHERE REGEXP_LIKE(
    mail,
    '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$',
    'c'
);
