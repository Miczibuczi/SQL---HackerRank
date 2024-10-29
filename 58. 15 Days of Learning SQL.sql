-- First answer, it doesn't work because LIMIT statement can't be used in a subquery in this MySQL version
DELIMITER $$
CREATE PROCEDURE AdvanceJoin(IN max_day INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cur_date date;
    CREATE TEMPORARY TABLE TempSubmissions (hacker_id INT) AS
    SELECT DISTINCT hacker_id
    FROM submissions
    WHERE submission_date = "2016-03-01";

    CREATE TEMPORARY TABLE Answer (submission_date DATE, unique_hackers INT, hacker_id INT, hacker_name VARCHAR(20));
    
    WHILE i <= max_day DO
        IF i < 10 THEN
            SET cur_date = CONCAT("2016-03-0", CAST(i AS CHAR));
        ELSE
            SET cur_date = CONCAT("2016-03-", CAST(i AS CHAR));
        END IF;

        INSERT INTO Answer (submission_date, hacker_id, hacker_name)
        SELECT DISTINCT submission_date, hacker_id, hacker_name
        FROM submissions
        WHERE submission_date = cur_date
        AND hacker_id IN (
            SELECT hacker_id
            FROM submissions
            WHERE submission_date = cur_date
            GROUP BY hacker_id
            ORDER BY COUNT(hacker_name) DESC, hacker_name DESC
            LIMIT 1
        );

        DELETE TempSubmissions
        FROM TempSubmissions
        LEFT JOIN (
            SELECT hacker_id
            FROM submissions
            WHERE submission_date = STR_TO_DATE(cur_date, '%Y-%m-%d')
        ) AS subquery2 ON TempSubmissions.hacker_id = subquery2.hacker_id
        WHERE subquery2.hacker_id IS NULL;

        UPDATE Answer
        SET unique_hackers = (
            SELECT COUNT(DISTINCT hacker_id)
            FROM TempSubmissions
        )
        WHERE submission_date = cur_date;

        SET i = i+1;
    END WHILE;

    SELECT * FROM Answer;
END$$
DELIMITER ;
CALL AdvanceJoin(15);





-- Second answer. It still doesn't work. I got the error: "ERROR 1044 (42000) at line 2: Access denied for user 'run_JKVIQO9shqJ'@'localhost' to database 'run_jkviqo9shqj'"
-- It seems that I can't create any procedures in this task, because an empty procedure which does nothing returns the same error
DELIMITER $$
CREATE PROCEDURE AdvanceJoin(IN max_day INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cur_date VARCHAR(10);
    DECLARE hacker_count INT;
    CREATE TEMPORARY TABLE TempSubmissions (hacker_id INT) AS
    SELECT DISTINCT hacker_id
    FROM submissions
    WHERE submission_date = "2016-03-01";

    CREATE TEMPORARY TABLE Answer (submission_date DATE, unique_hackers INT, hacker_id INT, hacker_name VARCHAR(20));
    
    WHILE i <= max_day DO
        IF i < 10 THEN
            SET cur_date = CONCAT("2016-03-0", CAST(i AS CHAR));
        ELSE
            SET cur_date = CONCAT("2016-03-", CAST(i AS CHAR));
        END IF;

        INSERT INTO Answer (submission_date, hacker_id, hacker_name)
        SELECT DISTINCT submissions.submission_date, submissions.hacker_id, submissions.hacker_name
        FROM submissions
        JOIN (
            SELECT hacker_id, COUNT(hacker_name) AS total_count
            FROM submissions
            WHERE submission_date = STR_TO_DATE(cur_date, '%Y-%m-%d')
            GROUP BY hacker_id
        ) as subquery1
        ON submissions.hacker_id = subquery1.hacker_id
        WHERE submissions.submission_date = STR_TO_DATE(cur_date, '%Y-%m-%d')
        ORDER BY total_count DESC, submissions.hacker_id DESC
        LIMIT 1;

        DELETE TempSubmissions
        FROM TempSubmissions
        LEFT JOIN (
            SELECT hacker_id
            FROM submissions
            WHERE submission_date = STR_TO_DATE(cur_date, '%Y-%m-%d')
        ) AS subquery2 ON TempSubmissions.hacker_id = subquery2.hacker_id
        WHERE subquery2.hacker_id IS NULL;

        SET hacker_count = (
            SELECT COUNT(hacker_id)
            FROM TempSubmissions
        );

        UPDATE Answer
        SET unique_hackers = hacker_count
        WHERE submission_date = STR_TO_DATE(cur_date, '%Y-%m-%d');

        SET i = i+1;
    END WHILE;

    SELECT * FROM Answer;
    DROP TEMPORARY TABLE IF EXISTS TempSubmissions;
    DROP TEMPORARY TABLE IF EXISTS Answer;
END$$
DELIMITER ;
CALL AdvanceJoin(15);