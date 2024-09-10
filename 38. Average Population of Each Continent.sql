SELECT continent, FLOOR(AVG(city.population))
FROM country
JOIN city ON country.code = city.countrycode
GROUP BY continent;