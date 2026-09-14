```sql
/*
    Find Books with No Available Copies

    Problem:
    Find all books that are currently borrowed and have
    zero copies available in the library.

    A book is currently borrowed when:
        return_date IS NULL

    Available copies:
        total_copies - current_borrowers

    Include a book only when:
        available_copies = 0

    Order:
        1. current_borrowers DESC
        2. title ASC


    Approach:
    1. Join library_books with borrowing_records.
    2. Count only records where return_date IS NULL.
    3. Group by book.
    4. Check:
           total_copies = current_borrowers
    5. Sort the result as required.
*/

SELECT
    lb.book_id,
    lb.title,
    lb.author,
    lb.genre,
    lb.publication_year,
    COUNT(br.record_id) AS current_borrowers
FROM library_books lb
JOIN borrowing_records br
    ON lb.book_id = br.book_id
WHERE br.return_date IS NULL
GROUP BY
    lb.book_id,
    lb.title,
    lb.author,
    lb.genre,
    lb.publication_year,
    lb.total_copies
HAVING COUNT(br.record_id) = lb.total_copies
ORDER BY
    current_borrowers DESC,
    lb.title ASC;
```
