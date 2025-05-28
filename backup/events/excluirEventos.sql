create event if not EXISTS excluir_eventos_antigos
    on schedule every 1 week
    starts current_timestamp + interval 5 minute 
    on completion preserve 
    enable 
do
    delete from evento 
    where data_hora < now() - interval 1 year;
