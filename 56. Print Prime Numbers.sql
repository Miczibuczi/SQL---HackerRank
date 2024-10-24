DELIMITER $$
CREATE PROCEDURE getPrimes(IN max_val INT)
BEGIN
    DECLARE num INT DEFAULT 2;
    DECLARE isPrime BIT DEFAULT 1;
    DECLARE prime_num INT;
    DECLARE i INT;
    DECLARE primes_count INT;
    CREATE TEMPORARY TABLE PrimeNumbers (Prime INT);
    WHILE num <= max_val DO
        SET isPrime = 1;
        SET i = 0;
        SET primes_count = (SELECT COUNT(*) FROM PrimeNumbers);
        inner_loop: WHILE i < primes_count DO
            SET prime_num = (SELECT Prime FROM PrimeNumbers LIMIT 1 OFFSET i);
            
            IF prime_num * prime_num > num THEN
                LEAVE inner_loop;
            END IF;
            
            IF num % prime_num = 0 THEN
                SET isPrime = 0;
                LEAVE inner_loop;
            END IF;
            
            SET i = i+1;
        END WHILE;
        
        IF isPrime = 1 THEN
            INSERT INTO PrimeNumbers (Prime) VALUES(num);
        END IF;
        
        SET num = num+1;
    END WHILE;
    SELECT GROUP_CONCAT(Prime SEPARATOR '&') FROM PrimeNumbers;
END$$
DELIMITER ;

CALL GetPrimes(1000);