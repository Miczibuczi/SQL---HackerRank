-- First answer
SELECT ROUND(SQRT(POWER(MAX(lat_n)-MIN(lat_n), 2)+POWER(MAX(long_w)-MIN(long_w), 2)), 4)
FROM station;


-- Second answer, more code but more readable
WITH P1_P2 AS (
    SELECT
        POWER(MAX(lat_n)-MIN(lat_n), 2) AS P1,
        POWER(MAX(long_w)-MIN(long_w), 2) AS P2
    FROM station)
SELECT ROUND(SQRT(P1+P2), 4)
FROM P1_P2;