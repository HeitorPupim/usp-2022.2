-- Q3: V
   		--produto cartesiano
	select * from jogador j, time t;
	
		--junção adequada e substituição
	select j.cpf, j.nome, round((sysdate - j.data_nasc)/365) as idade,
	    t.nome as time, t.estado as estado_time 
	        from jogador j
	         left join time t on t.nome = j.time;