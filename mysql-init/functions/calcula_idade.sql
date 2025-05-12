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
