```sql
/*
    LeetCode 1341 - Movie Rating

    Problem:
    Find two results:

    1. The user who rated the greatest number of movies.
       If there is a tie, return the lexicographically smaller name.

    2. The movie with the highest average rating in February 2020.
       If there is a tie, return the lexicographically smaller title.

    Return both results in one column named "results".


    Example:

    Output:
    +----------+
    | results  |
    +----------+
    | Daniel   |
    | Frozen 2 |
    +----------+


    Approach:

    Part 1:
    - Join Users and MovieRating.
    - Count how many movies each user rated.
    - Sort by count DESC and name ASC.
    - Take the first user.

    Part 2:
    - Join Movies and MovieRating.
    - Consider only ratings from February 2020.
    - Calculate average rating for each movie.
    - Sort by average DESC and title ASC.
    - Take the first movie.

    Finally:
    - Combine both answers using UNION ALL.
*/

(
    SELECT u.name AS results
    FROM Users u
    JOIN MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC, u.name ASC
    LIMIT 1
)

UNION ALL

(
    SELECT m.title AS results
    FROM Movies m
    JOIN MovieRating mr
        ON m.movie_id = mr.movie_id
    WHERE mr.created_at >= '2020-02-01'
      AND mr.created_at < '2020-03-01'
    GROUP BY m.movie_id, m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
);
```
