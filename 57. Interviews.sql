SELECT colleges.contest_id, MAX(contests.hacker_id), MAX(contests.name), SUM(agg_submission_stats.TS), SUM(agg_submission_stats.TAS), SUM(agg_view_stats.TV), SUM(agg_view_stats.TUV)
FROM challenges
LEFT JOIN (
    SELECT SUM(total_submissions) AS TS, SUM(total_accepted_submissions) AS TAS, challenge_id
    FROM submission_stats
    GROUP BY challenge_id
) AS agg_submission_stats
ON challenges.challenge_id=agg_submission_stats.challenge_id
LEFT JOIN (
    SELECT SUM(total_views) AS TV, SUM(total_unique_views) AS TUV, challenge_id
    FROM view_stats
    GROUP BY challenge_id
) AS agg_view_stats
ON challenges.challenge_id=agg_view_stats.challenge_id
JOIN colleges
ON colleges.college_id=challenges.college_id
JOIN contests
ON contests.contest_id=colleges.contest_id
GROUP BY colleges.contest_id
ORDER BY colleges.contest_id