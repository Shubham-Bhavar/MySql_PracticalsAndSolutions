/*
Question:
Find the first login date for each player.

Table: Activity
+-------------+---------+
| player_id   | int     |
| device_id   | int     |
| event_date  | date    |
| games_played| int     |
+-------------+---------+

(player_id, event_date) is the primary key.

Example:
Player 1 -> 2016-03-01, 2016-05-02
First login -> 2016-03-01

Player 2 -> 2017-06-25
First login -> 2017-06-25

Player 3 -> 2016-03-02, 2018-07-03
First login -> 2016-03-02
*/

SELECT
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
