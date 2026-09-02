/*
LeetCode 602 - Friend Requests II: Who Has the Most Friends?

Table: RequestAccepted
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+

Approach:
- A friendship is counted for both people.
- requester_id gets +1 friend.
- accepter_id gets +1 friend.
- Use UNION ALL to combine both sides.
- GROUP BY id and find the person with the maximum count.
*/

SELECT 
    id,
    COUNT(*) AS num
FROM
(
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
) AS friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
