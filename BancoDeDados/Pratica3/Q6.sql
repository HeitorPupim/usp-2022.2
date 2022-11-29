--Q6: V 

	-- Para	cada time,	selecionar:	nome, estado, saldo de gols, e a quantidade de jogos clássicos que jogou por ano,
	-- considerando apenas anos em que o time jogou	alguma	partida	(clássica ou não).
	
   	SELECT * FROM time;
	
  
   	SELECT p.TIME1, p.TIME2, EXTRACT(YEAR FROM p.data), j.classico  FROM PARTIDA p
   		left JOIN joga j ON (j.TIME1 = p.TIME1 AND j.TIME2 = p.TIME2) AND j.CLASSICO = 'S'
   		ORDER BY p.DATA asc;
   	
   		--final
   		SELECT t.NOME, t.ESTADO, t.SALDO_GOLS, EXTRACT(YEAR FROM p."DATA") AS ano, COUNT(j.CLASSICO) AS qtdepartida FROM PARTIDA p 
   		JOIN "TIME" t ON t.NOME = p.time1 OR t.NOME = p.TIME2
   		left JOIN joga j ON (j.TIME1 = p.TIME1 AND j.TIME2 = p.TIME2) AND j.CLASSICO = 'S'
   		GROUP BY t.nome, t.ESTADO, t.SALDO_GOLS, EXTRACT(YEAR FROM p."DATA")
   		ORDER BY ano asc;
   	