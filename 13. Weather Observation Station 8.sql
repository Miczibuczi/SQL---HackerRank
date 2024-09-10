SELECT DISTINCT city
FROM station
WHERE LEFT(city, 1) IN ("e", "a", "i", "o", "u")
AND RIGHT(city, 1) IN ("e", "a", "i", "o", "u");