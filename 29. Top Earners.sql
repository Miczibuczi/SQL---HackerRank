SELECT MAX(salary*months), COUNT(*)
FROM employee
WHERE salary*months = (SELECT MAX(months*salary) FROM employee);