SELECT SUM(population)
FROM city
WHERE countrycode IN (
    SELECT code
    FROM country
    WHERE continent = 'Asia'
);