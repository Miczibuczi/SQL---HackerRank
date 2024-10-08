WITH cte as (
    SELECT COUNT(*) AS challenges_created, hacker_id
    FROM challenges
    GROUP BY hacker_id
)
SELECT cte.hacker_id, hackers.name, cte.challenges_created
FROM cte
JOIN hackers ON hackers.hacker_id=cte.hacker_id
WHERE challenges_created=(SELECT MAX(challenges_created) FROM cte)
OR cte.hacker_id IN(
    SELECT MAX(hacker_id)
    FROM cte
    GROUP BY challenges_created
    HAVING COUNT(challenges_created) = 1
)
ORDER BY cte.challenges_created DESC, cte.hacker_id ASC