 delimiter //

create procedure total_ingressos_usuario(
    in p_id_usuario int,
    out p_total_ingressos int
)
begin 
    -- Inicializar o valor de saída 
    set p_total_ingressos = 0;

    -- Consultar e somar todos os ingressos comprados pelo usuário
select coalesce(sum(ic.quantidade), 0)
    into p_total_ingressos
    from ingresso_compra ic
    join compra c on ic.fk_id_compra = c.id_compra
    where c.fk_id_usuario = p_id_usuario;
end; //

delimiter ;

------------------------------------------------------------------------------------------------------

    -- Verifica se o procedure foi criado
show procedure status where db = "vio_yasmin";

set @total = 0;

    -- Chamar o procedure
call total_ingressos_usuario (2, @total);

select @total;