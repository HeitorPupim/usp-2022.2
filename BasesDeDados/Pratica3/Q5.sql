--Q5: V
select extract(month from data) as mes_partida, count(*) as contagem from partida
    left join joga on partida.time1 = joga.time1 and partida.time2 = joga.time2
    --where joga.classico = 'S'
    where extract(year from data) = 2018 and joga.classico = 'S'
    group by extract(month from data)
    order by CONTAGEM DESC;
