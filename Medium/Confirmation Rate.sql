/*
LeetCode 1934 - Confirmation Rate

Tables:
Signups(user_id, time_stamp)
Confirmations(user_id, time_stamp, action)

Goal:
Find confirmation rate for every user.

Formula:
confirmed messages / total messages

If user has no confirmation requests:
confirmation_rate = 0

Round to 2 decimal places.

Approach:
1. LEFT JOIN Signups with Confirmations
   -> keeps users who have no confirmations.
2. AVG(action = 'confirmed')
   -> confirmed = 1, timeout = 0.
3. COALESCE(..., 0)
   -> gives 0 for users with no requests.
4. ROUND(..., 2)
   -> round to 2 decimal places.
*/

SELECT
    s.user_id,
    ROUND(
        COALESCE(AVG(c.action = 'confirmed'), 0),
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;
