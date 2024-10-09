WITH start_dates AS (
    SELECT start_date, ROW_NUMBER() OVER() AS rn
    FROM projects
    WHERE start_date NOT IN (SELECT end_date FROM projects)
),
end_dates AS (
    SELECT end_date, ROW_NUMBER() OVER() AS rn
    FROM projects
    WHERE end_date NOT IN (SELECT start_date FROM projects)
)
SELECT start_dates.start_date, end_dates.end_date
FROM start_dates
JOIN end_dates ON start_dates.rn=end_dates.rn
ORDER BY end_dates.end_date-start_dates.start_date ASC;