WITH enumerated AS(
    SELECT *, ROW_NUMBER() OVER() AS rn
    FROM functions
)
SELECT DISTINCT enumerated.x, enumerated.y
FROM enumerated
JOIN enumerated AS enumerated2
ON enumerated.x=enumerated2.y
WHERE enumerated.y=enumerated2.x AND enumerated.rn<>enumerated2.rn AND enumerated.x<=enumerated.y
ORDER BY enumerated.x