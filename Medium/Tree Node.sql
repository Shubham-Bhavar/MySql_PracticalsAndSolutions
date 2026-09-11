/*
LeetCode 608 - Tree

Problem:
Classify every node in the tree as:

1. Root  -> p_id IS NULL
2. Leaf  -> has a parent but no children
3. Inner -> has a parent and at least one child

Approach:
- If p_id is NULL → Root
- Else if the node appears as a p_id → Inner
- Else → Leaf

EXISTS is used to check whether a node has children.

Time Complexity: O(n)
Space Complexity: O(1)
*/

SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'

        WHEN EXISTS
        (
            SELECT 1
            FROM Tree t2
            WHERE t2.p_id = t1.id
        )
        THEN 'Inner'

        ELSE 'Leaf'
    END AS type
FROM Tree t1;
