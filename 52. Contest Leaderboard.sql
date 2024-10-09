SELECT hackers.hacker_id, MAX(name), SUM(score) AS total_score
FROM (
    SELECT hacker_id, MAX(score) AS score
    FROM submissions
    GROUP BY hacker_id, challenge_id
) as subquery
JOIN hackers ON hackers.hacker_id=subquery.hacker_id
WHERE score > 0
GROUP BY hackers.hacker_id
ORDER BY total_score DESC, hackers.hacker_id ASC;