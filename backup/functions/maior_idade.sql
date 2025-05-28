delimiter $$

create function is_maior_idade(data_nascimento date)
returns boolean
deterministic
reads sql data
begin
    declare idade int;
    set idade = calcula_idade(data_nascimento);
    return idade >= 18;
end $$

delimiter ;
