
create table resumo_evento(
    id_evento int auto_increment primary key,
    total_ingressos int
);


delimiter //

create trigger atualizar_total_ingressos
after insert on ingresso_compra
for each row
begin
    declare v_id_evento int;
    declare v_quantidade int;

    -- buscar o evento do ingresso comprado
    select i.fk_id_evento into v_id_evento
    from ingresso i
    where i.id_ingresso = new.fk_id_ingresso;

    set v_quantidade = new.quantidade;

    -- verificar se o evento já está no resumo
    if exists (
        select 1 from resumo_evento where id_evento = v_id_evento
    ) then
        update resumo_evento
        set total_ingressos = total_ingressos + v_quantidade
        where id_evento = v_id_evento;
    else
        insert into resumo_evento (id_evento, total_ingressos)
        values (v_id_evento, v_quantidade);
    end if;
end; //

delimiter ;

-- testes
call registrar_compra(4, 9, 1);
SELECT * FROM resumo_evento;
