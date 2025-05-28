delimiter //

create procedure registrar_compra(
    in p_id_usuario int,
    in p_id_ingresso int,
    in p_quantidade int
)
begin
    declare v_id_compra int;
    declare v_data_evento datetime;

    -- Obtem a data do evento
    select e.data_hora into v_data_evento
    from ingresso i
    join evento e on i.fk_id_evento = e.id_evento
    where i.id_ingresso = p_id_ingresso;

    -- Verificar se a data do evento é menor que a atual
    if date(v_data_evento) < curdate() then
        signal sqlstate '45000'
        set message_text = 'ERRO_PROCEDURE - não é possível comprar ingressos para eventos passados.';
    end if;

    -- Criar registro na tabela 'compra'
    insert into compra (data_compra, fk_id_usuario)
    values (now(), p_id_usuario);

    -- Obter o ID da compra recém-criada
    set v_id_compra = last_insert_id();

    -- Registrar os ingressos comprados
    insert into ingresso_compra (fk_id_compra, fk_id_ingresso, quantidade)
    values (v_id_compra, p_id_ingresso, p_quantidade);

end //

delimiter ;
