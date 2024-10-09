SELECT name
FROM students
JOIN packages
ON students.ID=packages.ID
JOIN friends
ON friends.id=students.id
JOIN packages AS friend_packages
ON friend_packages.id=friends.friend_id
WHERE packages.salary<friend_packages.salary
ORDER BY friend_packages.salary