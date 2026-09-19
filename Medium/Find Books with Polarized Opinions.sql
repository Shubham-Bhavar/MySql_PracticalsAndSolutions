/*
    LeetCode - Find Books with Polarized Opinions

    Problem:
    --------
    Find books that have polarized opinions.

    A book has polarized opinions if:
    - It has at least 5 reading sessions.
    - It has at least one rating >= 4.
    - It has at least one rating <= 2.
    - At least 60% of its ratings are extreme ratings.

    Extreme rating:
    - Rating <= 2 OR Rating >= 4

    Calculate:
    - rating_spread = highest_rating - lowest_rating
    - polarization_score = extreme_ratings / total_sessions

    Return:
    - book_id
    - title
    - author
    - genre
    - pages
    - rating_spread
    - polarization_score

    Order the result by:
    1. polarization_score DESC
    2. title DESC

    Round polarization_score to 2 decimal places.
*/

SELECT
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,

    MAX(r.session_rating) - MIN(r.session_rating)
        AS rating_spread,

    ROUND(
        SUM(
            CASE
                WHEN r.session_rating <= 2
                  OR r.session_rating >= 4
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS polarization_score

FROM books b

JOIN reading_sessions r
    ON b.book_id = r.book_id

GROUP BY
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages

HAVING
    COUNT(*) >= 5

    AND SUM(
        CASE
            WHEN r.session_rating >= 4
            THEN 1
            ELSE 0
        END
    ) >= 1

    AND SUM(
        CASE
            WHEN r.session_rating <= 2
            THEN 1
            ELSE 0
        END
    ) >= 1

    AND SUM(
        CASE
            WHEN r.session_rating <= 2
              OR r.session_rating >= 4
            THEN 1
            ELSE 0
        END
    ) / COUNT(*) >= 0.60

ORDER BY
    polarization_score DESC,
    b.title DESC;
