delimiter //

create trigger trg_after_delete_compra
after delete on compra 
for each row 
begin   
    insert into historico_compra (id_compra, data_compra, id_usuario) 
    value (old.id_compra, old.data_compra, old.fk_id_usuario);
end; //

delimiter ;
