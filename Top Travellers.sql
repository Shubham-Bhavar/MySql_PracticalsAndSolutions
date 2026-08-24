-- Question:
-- Report the total distance traveled by each user.
-- Include users who have not taken any rides.
-- Sort by distance in descending order and name in ascending order.

SELECT
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r
    ON u.id = r.user_id
GROUP BY
    u.id,
    u.name
ORDER BY
    travelled_distance DESC,
    u.name ASC;
