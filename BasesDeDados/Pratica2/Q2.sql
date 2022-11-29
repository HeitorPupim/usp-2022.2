--Q2: V
select to_char(data, 'dd-mm-yyyy hh24:mi') as data, LOCAL, partida.TIME1, partida.TIME2
    from partida where
    time1 = 'PALMEIRAS'
    or time2 = 'PALMEIRAS';