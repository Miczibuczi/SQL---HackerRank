SELECT n,
    CASE
        WHEN p IS NULL THEN 'Root'
        WHEN n IN (SELECT p FROM BST) THEN 'Inner'
        ELSE 'Leaf'
    END
FROM BST
ORDER BY n;

--Second option with NOT IN
SELECT n,
    CASE
        WHEN p IS NULL THEN 'Root'
        WHEN n NOT IN (SELECT p FROM BST WHERE p IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END
FROM BST
ORDER BY n;