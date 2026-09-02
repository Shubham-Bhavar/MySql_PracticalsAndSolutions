/*
LeetCode 3475 - DNA Pattern Recognition

Table: Samples
+-------------+---------+
| sample_id   | int     |
| dna_sequence| varchar |
| species     | varchar |
+-------------+---------+

Patterns:
1. Starts with ATG
2. Ends with TAA, TAG, or TGA
3. Contains ATAT
4. Contains at least 3 consecutive G's

Approach:
- LEFT() checks the starting pattern.
- RIGHT() checks the ending pattern.
- LIKE '%ATAT%' checks whether ATAT exists anywhere.
- LIKE '%GGG%' checks for 3 or more consecutive G's.
- CASE returns 1 if the pattern exists, otherwise 0.
*/

SELECT
    sample_id,
    dna_sequence,
    species,

    CASE
        WHEN dna_sequence LIKE 'ATG%' THEN 1
        ELSE 0
    END AS has_start,

    CASE
        WHEN dna_sequence LIKE '%TAA'
          OR dna_sequence LIKE '%TAG'
          OR dna_sequence LIKE '%TGA'
        THEN 1
        ELSE 0
    END AS has_stop,

    CASE
        WHEN dna_sequence LIKE '%ATAT%' THEN 1
        ELSE 0
    END AS has_atat,

    CASE
        WHEN dna_sequence LIKE '%GGG%' THEN 1
        ELSE 0
    END AS has_ggg

FROM Samples
ORDER BY sample_id ASC;
