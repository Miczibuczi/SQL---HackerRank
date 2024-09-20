SELECT wands.id, subquery.age, subquery.coins_needed, subquery.power
FROM wands
JOIN wands_property ON wands.code = wands_property.code
JOIN (
    SELECT age, MIN(coins_needed) AS coins_needed, power
    FROM wands
    JOIN wands_property ON wands.code = wands_property.code
    WHERE is_evil = 0
    GROUP BY age, power
) AS subquery
ON wands_property.age=subquery.age
AND wands.power = subquery.power
AND wands.coins_needed = subquery.coins_needed
ORDER BY power DESC, age DESC;