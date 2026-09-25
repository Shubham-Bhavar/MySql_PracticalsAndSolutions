/*
    LeetCode 3374 - First Letter Capitalization II

    Problem:
    --------
    Given a table user_content(content_id, content_text), transform
    each word according to these rules:

    1. If a word starts with a non-English letter, leave the entire
       word unchanged.

    2. If a word contains two or more non-empty English-letter parts
       connected by hyphens, capitalize the first letter of every part
       and lowercase the remaining letters.

       Example:
       top-rated  -> Top-Rated
       FR-ONT-end -> Fr-Ont-End

    3. Otherwise, capitalize the first letter of the word and lowercase
       all remaining English letters.

    4. Preserve all spaces and special characters.

    Example:
    --------
    Input:
    1 | hello world of SQL
    2 | the QUICK-brown fox
    3 | modern-day DATA science
    4 | web-based FRONT-end development

    Output:
    1 | Hello World Of Sql
    2 | The Quick-Brown Fox
    3 | Modern-Day Data Science
    4 | Web-Based Front-End Development

    Important Edge Cases:
    ---------------------
    foo--bar          -> Foo--bar
    -baz              -> -baz
    lOO-daR-@Daz-     -> Loo-dar-@daz-

    Approach:
    ---------
    Use a recursive CTE to process the text character by character.

    For every word:
    - Check its first character.
    - Check whether the complete word is a valid hyphenated word.
    - Keep the word type while processing its characters.
    - Apply capitalization according to the word type.

    Word Types:
    0 = starts with a non-English letter
    1 = normal word
    2 = valid hyphenated word

    Time Complexity:
    O(n)

    Space Complexity:
    O(n)
*/

WITH RECURSIVE cte AS
(
    /* Start with the first word */
    SELECT
        content_id,
        content_text,
        1 AS pos,
        CAST('' AS CHAR(1000)) AS result,

        CASE
            /* Empty content */
            WHEN CHAR_LENGTH(content_text) = 0
                THEN 0

            /* Word starts with a non-English letter */
            WHEN SUBSTRING(content_text, 1, 1)
                 NOT REGEXP '[A-Za-z]'
                THEN 0

            /* Valid hyphenated word */
            WHEN SUBSTRING(
                     content_text,
                     1,
                     LOCATE(
                         ' ',
                         CONCAT(content_text, ' ')
                     ) - 1
                 ) REGEXP '^[A-Za-z]+(-[A-Za-z]+)+$'
                THEN 2

            /* Normal word */
            ELSE 1
        END AS word_type

    FROM user_content

    UNION ALL

    SELECT
        content_id,
        content_text,
        pos + 1,

        CONCAT(
            result,

            CASE

                /* Space */
                WHEN SUBSTRING(content_text, pos, 1) = ' '
                    THEN ' '

                /* Word starts with a special character */
                WHEN word_type = 0
                    THEN SUBSTRING(content_text, pos, 1)

                /* Normal word */
                WHEN word_type = 1
                    THEN
                        CASE
                            WHEN pos = 1
                              OR SUBSTRING(
                                     content_text,
                                     pos - 1,
                                     1
                                 ) = ' '
                            THEN UPPER(
                                SUBSTRING(content_text, pos, 1)
                            )

                            ELSE LOWER(
                                SUBSTRING(content_text, pos, 1)
                            )
                        END

                /* Valid hyphenated word */
                WHEN word_type = 2
                    THEN
                        CASE
                            WHEN pos = 1
                              OR SUBSTRING(
                                     content_text,
                                     pos - 1,
                                     1
                                 ) IN (' ', '-')
                            THEN UPPER(
                                SUBSTRING(content_text, pos, 1)
                            )

                            ELSE LOWER(
                                SUBSTRING(content_text, pos, 1)
                            )
                        END

            END
        ),

        /*
            Determine the type of the next word when a space
            is encountered.
        */
        CASE

            WHEN SUBSTRING(content_text, pos, 1) <> ' '
                THEN word_type

            /* No next word */
            WHEN pos = CHAR_LENGTH(content_text)
                THEN 0

            /* Next word starts with a non-letter */
            WHEN SUBSTRING(content_text, pos + 1, 1)
                 NOT REGEXP '[A-Za-z]'
                THEN 0

            /* Next word is a valid hyphenated word */
            WHEN SUBSTRING(
                     content_text,
                     pos + 1,
                     LOCATE(
                         ' ',
                         CONCAT(
                             SUBSTRING(content_text, pos + 1),
                             ' '
                         )
                     ) - 1
                 ) REGEXP '^[A-Za-z]+(-[A-Za-z]+)+$'
                THEN 2

            /* Otherwise normal word */
            ELSE 1

        END AS word_type

    FROM cte

    WHERE pos <= CHAR_LENGTH(content_text)
)

SELECT
    content_id,
    content_text AS original_text,
    result AS converted_text
FROM cte
WHERE pos = CHAR_LENGTH(content_text) + 1
ORDER BY content_id;
