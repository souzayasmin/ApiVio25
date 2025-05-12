DELIMITER $$

CREATE FUNCTION total_compras_usuario(id_usuario INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM compra
    WHERE fk_id_usuario = id_usuario;

    RETURN total;
END $$

DELIMITER ;

    -- Exeução da query
select total_compras_usuario(1) as 'Total de compras';
