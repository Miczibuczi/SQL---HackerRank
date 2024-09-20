SELECT
    CASE
        WHEN grade >= 8 THEN name
        ELSE NULL
    END,
    grade,
    marks
FROM students
JOIN grades ON students.marks >= grades.min_mark AND students.marks <= grades.max_mark
ORDER BY
    CASE
        WHEN grade>=8 THEN 1
        ELSE 2
    END,
    grade DESC,
    name ASC,
    marks ASC;