--Q2: V 
select 
    j.nome, 
    j.data_nasc, 
    j.time, 
    p.data,
    p.local,
    jo.classico
        from jogador j
        join partida p  on j.time = p.time1 or j.time = p.time2
        join joga jo on jo.time1 = p.time1 and jo.time2 = p.time2
        --where classico is not null
        order by p.data asc;