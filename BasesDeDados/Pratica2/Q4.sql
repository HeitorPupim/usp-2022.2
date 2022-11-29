--Q4: V
    --1)
    select j.cpf, j.nome, j.data_nasc, t.nome from jogador j, time t 
        where j.time = t.nome
            and t.estado = 'SP';
    
    --2)
    select j.cpf, j.nome, j.data_nasc, t.nome from jogador j
        join time t on t.nome = j.time
        where t.estado = 'SP';
         