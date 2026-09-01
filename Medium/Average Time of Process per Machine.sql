/*
===========================================================
LeetCode 1661 - Average Time of Process per Machine
===========================================================

TABLE: Activity

Columns:
machine_id     -> ID of the machine
process_id     -> ID of the process
activity_type  -> 'start' or 'end'
timestamp      -> Time when the activity occurred

TASK:
Find the average processing time for each machine.

Processing time:
    end timestamp - start timestamp

Return:
    machine_id
    processing_time

Round processing_time to 3 decimal places.
===========================================================
*/

SELECT
    machine_id,

    ROUND(
        AVG(
            CASE
                WHEN activity_type = 'end' THEN timestamp
            END
        )
        -
        AVG(
            CASE
                WHEN activity_type = 'start' THEN timestamp
            END
        ),
        3
    ) AS processing_time

FROM Activity

GROUP BY machine_id;
