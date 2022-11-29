--Q1: V 
select t.nome, t.estado from uniforme u 
    left join time t on u.time = t.nome
    where cor_principal is null and u.tipo = 'TITULAR';
