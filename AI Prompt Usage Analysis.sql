-- Question:
-- Analyze AI prompt usage patterns for each user.
--
-- Requirements:
-- 1. User must have at least 3 prompts.
-- 2. Calculate total prompt count.
-- 3. Calculate average tokens per prompt.
-- 4. User must have at least one prompt with tokens
--    greater than their own average token usage.
-- 5. Sort by average tokens DESC, then user_id ASC.

SELECT
    user_id,
    COUNT(*) AS prompt_count,
    ROUND(AVG(tokens), 2) AS avg_tokens
FROM prompts
GROUP BY user_id
HAVING
    COUNT(*) >= 3
    AND MAX(tokens) > AVG(tokens)
ORDER BY
    avg_tokens DESC,
    user_id ASC;
