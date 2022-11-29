-- Q8: 
    select t.nome, u.cor_principal from uniforme u
        join time t on t.nome = u.time
        where t.estado = 'MG' 
        and u.tipo = 'TITULAR';