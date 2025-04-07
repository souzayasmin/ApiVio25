-- Criação de fuction
delimiter $$

create function calcula_idade(datanascimento date)
returns int
deterministic
contains sql
begin 
    declare idade int;
    set idade = timestampdiff(year, datanascimento, curdate());
    return idade;
end; $$

delimiter ; 

-----------------------------------------------------------------------------------------------------

    -- Verifica se a função verificada foi criada
show create function calcula_idade;

    -- Utilização da função
select name, calcula_idade(data_nascimento) as idade 
from usuario;

-----------------------------------------------------------------------------------------------------

delimiter $$

create function status_sistema()
return varchar(50)
no sql
begin
    return 'Sistema operando normalmente'
end; $$

delimiter ; 

    -- Exeução da query
select status_sistema();

-----------------------------------------------------------------------------------------------------

delimiter $$

create function total_compras_usuario(id_usuario int)
returns int
reads sql data
begin
    declare total int;

    select count(*) into total
    from compra
    where id_usuario = compra.fk_id_usuario;

    return total;

end; $$

delimiter ;

    -- Exeução da query
select total_compras_usuario(1) as 'Total de compras';

-----------------------------------------------------------------------------------------------------

-- Tabela para testar a clásula modifies sql data
create table log_evento(
    id_log int auto_increment primary key,
    mensagem varchar(255),
    data_log datetime default current_timestamp
);


delimiter $$

create function registrar_log_evento(texto varchar(255))
returns varchar(50)
not deterministic
modifies sql data
begin
    insert into log_evento(mensagem)
    values (texto);

    return 'Log inserido com sucesso';
end; $$

delimiter ;

show create function registrar_log_evento;

    -- Vizualiza o estasdo da variãvel de contronle para permissões de criçaõ de funão
show variables like 'log_bin_trust_fuction_creators';

set global log_bin_trust_fuction_creators =1;

select registrar_log_evento('teste')as log;

-----------------------------------------------------------------------------------------------------

delimiter $$

create function mensagem_boas_vindas(nome_usuario varchar(100))
returns varchar(255)
deterministic
contains sql 
begin
    declare msg varchar(255);
    set msg = concat('Olá,' nome_usuario, '! Seja bem-vindo(a) ao sistema VIO')
    return msg;
end; $$

delimiter ;

