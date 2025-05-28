CREATE EVENT IF NOT EXISTS reajuste_precos_eventos
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
ENABLE
DO
    UPDATE ingresso 
    SET preco = preco * 1.10
    WHERE fk_id_evento IN (
        SELECT id_evento 
        FROM evento 
        WHERE data_hora BETWEEN NOW() AND NOW() + INTERVAL 7 DAY
    );
