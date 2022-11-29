--Q6: V
    select p.time1, p.time2, p.data, p.placar,j.classico from partida p 
        join joga j on j.time1 = p.time1
         where p.local = 'SANTOS';
    