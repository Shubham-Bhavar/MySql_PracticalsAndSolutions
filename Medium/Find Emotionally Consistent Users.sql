/*
    LeetCode 3808 - Find Emotionally Consistent Users

    Problem:
    --------
    Identify users who satisfy both conditions:

    1. The user has reacted to at least 5 different content items.
    2. At least 60% of the user's reactions are of the same type.

    Return:
    user_id,
    dominant_reaction,
    reaction_ratio

    reaction_ratio = dominant reaction count / total reaction count

    Round reaction_ratio to 2 decimal places.

    Order by:
    1. reaction_ratio DESC
    2. user_id ASC
*/

WITH reaction_counts AS
(
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),
ranked_reactions AS
(
    SELECT
        user_id,
        reaction,
        reaction_count,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY reaction_count DESC, reaction ASC
        ) AS rn
    FROM reaction_counts
),
user_totals AS
(
    SELECT
        user_id,
        COUNT(*) AS total_reactions,
        COUNT(DISTINCT content_id) AS total_content
    FROM reactions
    GROUP BY user_id
)
SELECT
    r.user_id,
    r.reaction AS dominant_reaction,
    ROUND(
        r.reaction_count / u.total_reactions,
        2
    ) AS reaction_ratio
FROM ranked_reactions r
JOIN user_totals u
    ON r.user_id = u.user_id
WHERE r.rn = 1
  AND u.total_content >= 5
  AND r.reaction_count / u.total_reactions >= 0.60
ORDER BY
    reaction_ratio DESC,
    r.user_id ASC;
