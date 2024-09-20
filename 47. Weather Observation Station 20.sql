SELECT ROUND(lat_n, 4)
FROM (
    SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n) AS row_num
    FROM station
) AS ranked_station
WHERE row_num = CEIL((SELECT COUNT(*) FROM station) / 2);