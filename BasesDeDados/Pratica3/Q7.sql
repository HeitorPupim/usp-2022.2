--Q7: X

	SELECT t.NOME, COUNT(*) AS partidas_sem_gols
		FROM "TIME" t
		JOIN PARTIDA p ON p.TIME1 = t.NOME OR p.TIME2 = t.NOME
		WHERE t.NOME IN ( SELECT DISTINCT t2.NOME 
				FROM PARTIDA p2 
				JOIN JOGA j2 ON j2.TIME1 = p2.TIME1 AND j2.TIME2 = p2.TIME2
				JOIN "TIME" t2 ON t2.NOME = p2.TIME1 OR t2.NOME = p2.TIME2 
				WHERE t2.TIPO = 'PROFISSIONAL' AND j2.CLASSICO = 'S')
		AND  (
    		(t.nome = p.time1 AND REGEXP_LIKE(p.placar, '^(0|00)\X[[:digit:]]{1,2}')) OR
		    (t.nome = p.time2 AND REGEXP_LIKE(p.placar, '[[:digit:]]{1,2}\X(0|00)$'))
		    )
		    GROUP BY t.NOME 
		    HAVING count(*) >= 2;