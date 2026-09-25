/*
    LeetCode - Find Users with Persistent Behavior Patterns

    Problem:
    --------
    Identify behaviorally stable users.

    A user is stable if:
    - There are at least 5 consecutive days.
    - The user performs exactly one action per day.
    - The action is the same on all consecutive days.

    If a user has multiple valid streaks, return only the
    longest streak.

    Return:
    - user_id
    - action
    - streak_length
    - start_date
    - end_date

    Order by:
    1. streak_length DESC
    2. user_id ASC
*/

WITH valid_days AS
(
    SELECT
        user_id,
        action_date,
        MAX(action) AS action
    FROM activity
    GROUP BY
        user_id,
        action_date
    HAVING COUNT(*) = 1
),
grouped AS
(
    SELECT
        user_id,
        action,
        action_date,
        DATE_SUB(
            action_date,
            INTERVAL ROW_NUMBER() OVER (
                PARTITION BY user_id, action
                ORDER BY action_date
            ) DAY
        ) AS grp
    FROM valid_days
),
streaks AS
(
    SELECT
        user_id,
        action,
        COUNT(*) AS streak_length,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date
    FROM grouped
    GROUP BY
        user_id,
        action,
        grp
),
ranked AS
(
    SELECT
        user_id,
        action,
        streak_length,
        start_date,
        end_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY streak_length DESC, start_date ASC
        ) AS rn
    FROM streaks
)
SELECT
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM ranked
WHERE rn = 1
  AND streak_length >= 5
ORDER BY
    streak_length DESC,
    user_id ASC;
