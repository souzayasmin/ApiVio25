DELIMITER $$

CREATE FUNCTION status_sistema()
RETURNS VARCHAR(50)
NO SQL
BEGIN
    RETURN 'Sistema operando normalmente';
END $$

DELIMITER ;
