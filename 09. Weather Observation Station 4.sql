SELECT COUNT(*) - (SELECT COUNT(DISTINCT City) FROM Station)
FROM Station;