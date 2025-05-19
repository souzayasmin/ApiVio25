delimiter //

create trigger verifica_data_envento
before insert on ingresso_compra
for each row
begin
    declare data_evento datetime;

    -- buscar data do vento
    select e.data_hora into data_evento
    from ingresso i join evento e on i.fk_id_evento = e.fk_id_evento
    where i.id_ingresso = new.fk_id_ingresso;

    -- verificar se o evento já ocorreu
    if date(data_evento) < curdate() then
        signal sqlstate '45000'
        set message_text = 'Não é possível comprar ingressos para eventos passados.';
    end if;   

end; //

delimiter;



    