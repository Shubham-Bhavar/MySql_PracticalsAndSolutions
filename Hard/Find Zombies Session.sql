/*
LeetCode 3673. Find Zombie Sessions

Difficulty: Hard

Problem Statement:
Find sessions that satisfy ALL these conditions:

1. Session duration is more than 30 minutes.
2. Session has at least 5 scroll events.
3. Click-to-scroll ratio is less than 0.20.
4. Session has no purchase events.

Return:
- session_id
- user_id
- session_duration_minutes
- scroll_count

Order by:
1. scroll_count DESC
2. session_id ASC

Approach:
1. Group events by session_id.
2. Find the first and last event time.
3. Calculate session duration.
4. Count scroll and click events.
5. Check whether a purchase exists.
6. Apply all conditions using HAVING.

Important:
click_to_scroll_ratio = click_count / scroll_count

The ratio must be STRICTLY less than 0.20.
*/

SELECT
    session_id,
    user_id,

    TIMESTAMPDIFF(
        MINUTE,
        MIN(event_timestamp),
        MAX(event_timestamp)
    ) AS session_duration_minutes,

    SUM(
        CASE
            WHEN event_type = 'scroll' THEN 1
            ELSE 0
        END
    ) AS scroll_count

FROM app_events

GROUP BY
    session_id,
    user_id

HAVING
    TIMESTAMPDIFF(
        MINUTE,
        MIN(event_timestamp),
        MAX(event_timestamp)
    ) > 30

    AND SUM(
        CASE
            WHEN event_type = 'scroll' THEN 1
            ELSE 0
        END
    ) >= 5

    AND
    (
        SUM(
            CASE
                WHEN event_type = 'click' THEN 1
                ELSE 0
            END
        ) * 1.0
        /
        SUM(
            CASE
                WHEN event_type = 'scroll' THEN 1
                ELSE 0
            END
        )
    ) < 0.20

    AND SUM(
        CASE
            WHEN event_type = 'purchase' THEN 1
            ELSE 0
        END
    ) = 0

ORDER BY
    scroll_count DESC,
    session_id ASC;