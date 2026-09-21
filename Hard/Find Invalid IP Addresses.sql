/*
    Find Invalid IP Addresses

    Find IP addresses that are invalid IPv4 addresses.

    An IP address is valid if:
    - It contains exactly 4 octets.
    - Each octet is between 0 and 255.
    - No octet has leading zeros.
    
    Return:
    ip, invalid_count

    Order by invalid_count DESC and ip DESC.
*/

SELECT
    ip,
    COUNT(*) AS invalid_count
FROM logs
WHERE ip NOT REGEXP
'^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)([.](25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)){3}$'
GROUP BY ip
ORDER BY
    invalid_count DESC,
    ip DESC;
