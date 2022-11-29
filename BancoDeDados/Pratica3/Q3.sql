--Q3: V
select time.nome, time.estado, diretor.nome as diretor_time from time
    left join diretor on time.nome = diretor.time;
