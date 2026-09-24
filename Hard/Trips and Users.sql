/*
    LeetCode 262 - Trips and Users

    Problem:
    --------
    Find the cancellation rate of trips where both the client and
    driver are not banned.

    Consider trips between:
    2013-10-01 and 2013-10-03

    Cancellation Rate =
    Number of cancelled trips / Total valid trips

    A trip is valid only when:
    - Client is not banned
    - Driver is not banned

    Return:
    Day
    Cancellation Rate

    Round Cancellation Rate to 2 decimal places.
*/

SELECT
    t.request_at AS Day,
    ROUND(
        AVG(
            CASE
                WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client')
                THEN 1
                ELSE 0
            END
        ),
        2
    ) AS `Cancellation Rate`
FROM Trips t
JOIN Users c
    ON t.client_id = c.users_id
JOIN Users d
    ON t.driver_id = d.users_id
WHERE c.banned = 'No'
  AND d.banned = 'No'
  AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;
