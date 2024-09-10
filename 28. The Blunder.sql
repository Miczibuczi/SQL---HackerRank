SELECT CEIL(actual_table.average - miscalculated_table.average)
FROM (
    SELECT AVG(salary) as average
    FROM employees
) AS actual_table,
(
    SELECT AVG(CAST(REPLACE(CAST(salary AS CHAR), '0', '') AS UNSIGNED)) as average
    FROM employees
) AS miscalculated_table;