delimiter //

create procedure registrar_presenca(
    in p_id_compra int,
    in p_id_evento int
)
begin 
    -- Registrar presença
    insert into presenca (data_hora_checkin, fk_id_evento, fk_id_compra)
    values (now(), p_id_evento, p_id_compra);
end; //

delimiter ;


call registrar_presenca (1,3);
