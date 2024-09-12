-- First answer, 37 seconds
SELECT company.company_code,
       founder,
       COUNT(DISTINCT lead_manager.lead_manager_code),
       COUNT(DISTINCT senior_manager.senior_manager_code),
       COUNT(DISTINCT manager.manager_code),
       COUNT(DISTINCT employee.employee_code)
FROM company
JOIN lead_manager ON company.company_code = lead_manager.company_code
JOIN senior_manager ON company.company_code = senior_manager.company_code
JOIN manager ON company.company_code = manager.company_code
JOIN employee ON company.company_code = employee.company_code
GROUP BY company_code, founder
ORDER BY company.company_code;


-- Second answer, also 37s
SELECT
    company_code,
    founder,
    (SELECT COUNT(DISTINCT lead_manager.lead_manager_code)
        FROM lead_manager WHERE company.company_code = lead_manager.company_code),
    (SELECT COUNT(DISTINCT senior_manager.senior_manager_code)
        FROM senior_manager WHERE company.company_code = senior_manager.company_code),
    (SELECT COUNT(DISTINCT manager.manager_code)
        FROM manager WHERE company.company_code = manager.company_code),
    (SELECT COUNT(DISTINCT employee.employee_code)
        FROM employee WHERE company.company_code = employee.company_code)
FROM company
ORDER BY company.company_code;