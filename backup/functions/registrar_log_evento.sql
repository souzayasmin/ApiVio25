-- Tabela para testar a clásula modifies sql data
create table log_evento(
    id_log int auto_increment primary key,
    mensagem varchar(255),
    data_log datetime default current_timestamp
);


delimiter $$

create procedure registrar_log_evento(in texto varchar(255))
begin
    insert into log_evento(mensagem)
    values (texto);
end $$

delimiter ;


show create function registrar_log_evento;

    -- Vizualiza o estasdo da variãvel de contronle para permissões de criçaõ de funão
show variables like 'log_bin_trust_fuction_creators';

set global log_bin_trust_fuction_creators =1;

select registrar_log_evento('teste')as log;