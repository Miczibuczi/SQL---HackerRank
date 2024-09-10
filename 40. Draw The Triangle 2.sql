DELIMITER //

CREATE PROCEDURE P(n INT)
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= n DO
        SELECT REPEAT('* ', i);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL P(20);