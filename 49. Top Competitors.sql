SELECT hacker_id, name
FROM (
    SELECT hackers.hacker_id, name, COUNT(hackers.hacker_id) AS tasks_count
    FROM submissions
    JOIN challenges ON submissions.challenge_id = challenges.challenge_id
    INNER JOIN difficulty ON submissions.score = difficulty.score AND challenges.difficulty_level = difficulty.difficulty_level
    JOIN hackers ON submissions.hacker_id = hackers.hacker_id
    GROUP BY hackers.hacker_id, name
    HAVING tasks_count > 1
    ORDER BY tasks_count DESC, hackers.hacker_id ASC
) AS RankedHackers;