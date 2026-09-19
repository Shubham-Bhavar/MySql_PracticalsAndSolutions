/*
    LeetCode 3601 - Find Drivers with Improved Fuel Efficiency

    ------------------------------------------------------------
    Problem:
    ------------------------------------------------------------
    Find drivers whose average fuel efficiency improved
    in the second half of the year compared with the first half.

    Fuel efficiency:
        efficiency = distance_km / fuel_consumed

    First half:
        January to June

    Second half:
        July to December

    Return:
        - driver_id
        - driver_name
        - first_half_avg
        - second_half_avg
        - efficiency_improvement

    Conditions:
        1. Driver must have data in both halves.
        2. Second-half average must be greater than first-half average.
        3. Round averages and improvement to 2 decimals.

    Order:
        1. efficiency_improvement DESC
        2. driver_name ASC


    ------------------------------------------------------------
    Approach:
    ------------------------------------------------------------

    Step 1:
    Calculate efficiency for every trip.

        distance_km / fuel_consumed

    Step 2:
    Separate trips into:
        January-June  -> First half
        July-December -> Second half

    Step 3:
    Calculate average efficiency for each driver.

    Step 4:
    Keep only drivers whose second-half efficiency
    is greater than first-half efficiency.

    Step 5:
    Join with drivers table to get driver_name.

    Step 6:
    Sort by improvement.


    ------------------------------------------------------------
    SQL Concepts Used:
    ------------------------------------------------------------

    - CTE (WITH)
    - MONTH()
    - CASE WHEN
    - AVG()
    - GROUP BY
    - JOIN
    - ROUND()
    - IS NOT NULL
    - ORDER BY
*/


WITH trip_efficiency AS
(
    /*
        Step 1:
        Calculate efficiency for every trip.
    */
    SELECT
        driver_id,
        MONTH(trip_date) AS trip_month,
        distance_km / fuel_consumed AS efficiency

    FROM trips
),

driver_average AS
(
    /*
        Step 2:
        Calculate average efficiency for each driver.

        January-June  -> First half
        July-December -> Second half
    */
    SELECT
        driver_id,

        AVG(
            CASE
                WHEN trip_month BETWEEN 1 AND 6
                THEN efficiency
            END
        ) AS first_half_avg,

        AVG(
            CASE
                WHEN trip_month BETWEEN 7 AND 12
                THEN efficiency
            END
        ) AS second_half_avg

    FROM trip_efficiency

    GROUP BY driver_id
)

SELECT
    d.driver_id,
    d.driver_name,

    ROUND(a.first_half_avg, 2) AS first_half_avg,

    ROUND(a.second_half_avg, 2) AS second_half_avg,

    ROUND(
        a.second_half_avg - a.first_half_avg,
        2
    ) AS efficiency_improvement

FROM drivers d

JOIN driver_average a
    ON d.driver_id = a.driver_id

WHERE
    /*
        Driver must have data in both halves.
    */
    a.first_half_avg IS NOT NULL
    AND a.second_half_avg IS NOT NULL

    /*
        Efficiency must actually improve.
    */
    AND a.second_half_avg > a.first_half_avg

ORDER BY
    efficiency_improvement DESC,
    d.driver_name ASC;
