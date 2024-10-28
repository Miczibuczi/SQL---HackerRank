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

        UPDATE TempSubmissions
        JOIN (
            SELECT hacker_id
            FROM submissions
            WHERE submission_date = cur_date
        ) as subquery
        ON TempSubmissions.hacker_id = subquery.hacker_id;

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