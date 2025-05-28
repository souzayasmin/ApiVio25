CREATE EVENT IF NOT EXISTS arquivar_compras_antigas
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
ENABLE
DO
    INSERT INTO historico_compra(id_compra, data_compra, fk_id_usuario)
    SELECT id_compra, data_compra, fk_id_usuario
    FROM compra
    WHERE data_compra < NOW() - INTERVAL 6 MONTH;
