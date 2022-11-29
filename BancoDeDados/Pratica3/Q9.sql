--Q9: V
	--criar uma tupla de teste para verificar o valor zero.
INSERT INTO JOGA(TIME1,TIME2,CLASSICO) 
	VALUES('INTER', 'CHAPECOENSE', 'S');
	
	--query:
	SELECT j.TIME1, j.TIME2, COUNT(p.TIME1) AS quantidade_confrontos 
		FROM JOGA j
		LEFT JOIN PARTIDA p ON (j.TIME1 = p.TIME1 AND j.TIME2 = p.TIME2)
		WHERE j.CLASSICO = 'S'
		GROUP BY j.TIME1, j.TIME2
		ORDER BY quantidade_confrontos DESC;