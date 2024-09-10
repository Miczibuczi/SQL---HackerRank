DELIMITER //

CREATE PROCEDURE P(n INT)
BEGIN
    DECLARE i INT;
    SET i = 0;
    WHILE i < n DO
        SELECT REPEAT('* ', n - i);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL P(20);