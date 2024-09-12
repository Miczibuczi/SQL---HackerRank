SELECT CONCAT(name, '(', LEFT(occupation, 1), ')')
FROM occupations
ORDER BY name ASC;

SELECT 'There are a total of', COUNT(*), CONCAT(LOWER(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation) ASC, occupation ASC;