/*
    LeetCode - Find Churn Risk Customers

    Problem:
    --------
    Find users who:
    1. Are currently active.
    2. Have at least one downgrade.
    3. Current monthly amount is less than 50% of their
       historical maximum monthly amount.
    4. Have been subscribed for at least 60 days.

    Return:
    user_id,
    current_plan,
    current_monthly_amount,
    max_historical_amount,
    days_as_subscriber

    Order by days_as_subscriber DESC, user_id ASC.
*/

WITH user_stats AS
(
    SELECT
        user_id,
        MIN(event_date) AS first_date,
        MAX(event_date) AS last_date,
        MAX(monthly_amount) AS max_historical_amount,
        MAX(CASE
            WHEN event_type = 'downgrade' THEN 1
            ELSE 0
        END) AS has_downgrade
    FROM subscription_events
    GROUP BY user_id
),
last_event AS
(
    SELECT
        s.user_id,
        s.plan_name AS current_plan,
        s.monthly_amount AS current_monthly_amount,
        s.event_type,
        ROW_NUMBER() OVER (
            PARTITION BY s.user_id
            ORDER BY s.event_date DESC, s.event_id DESC
        ) AS rn
    FROM subscription_events s
)
SELECT
    l.user_id,
    l.current_plan,
    l.current_monthly_amount,
    u.max_historical_amount,
    DATEDIFF(u.last_date, u.first_date) AS days_as_subscriber
FROM user_stats u
JOIN last_event l
    ON u.user_id = l.user_id
WHERE l.rn = 1
  AND l.event_type <> 'cancel'
  AND u.has_downgrade = 1
  AND l.current_monthly_amount * 2 < u.max_historical_amount
  AND DATEDIFF(u.last_date, u.first_date) >= 60
ORDER BY
    days_as_subscriber DESC,
    l.user_id ASC;
