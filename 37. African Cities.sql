SELECT name
FROM city
WHERE countrycode IN(
    SELECT CODE
    FROM country
    WHERE continent = 'Africa'
);