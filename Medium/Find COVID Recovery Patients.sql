/*
    LeetCode 3586 - Find COVID Recovery Patients

    Problem:
    --------
    Find patients who have recovered from COVID.

    A patient is recovered if:
    1. They have at least one Positive test.
    2. They later have at least one Negative test.
    3. The Negative test must be on a later date than the Positive test.

    Recovery time is calculated as:
        First Negative Test After Positive
        -
        First Positive Test

    Return:
    patient_id,
    patient_name,
    age,
    recovery_time

    Order by:
    1. recovery_time ASC
    2. patient_name ASC
*/

WITH first_positive AS
(
    SELECT
        patient_id,
        MIN(test_date) AS positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative AS
(
    SELECT
        c.patient_id,
        MIN(c.test_date) AS negative_date
    FROM covid_tests c
    JOIN first_positive p
        ON c.patient_id = p.patient_id
    WHERE c.result = 'Negative'
      AND c.test_date > p.positive_date
    GROUP BY c.patient_id
)
SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(n.negative_date, fp.positive_date) AS recovery_time
FROM patients p
JOIN first_positive fp
    ON p.patient_id = fp.patient_id
JOIN first_negative n
    ON p.patient_id = n.patient_id
ORDER BY
    recovery_time ASC,
    p.patient_name ASC;
