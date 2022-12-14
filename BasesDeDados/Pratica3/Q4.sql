--Q4: V
    
SELECT COUNT(p.TIME1) AS partidas, j.classico FROM PARTIDA p
RIGHT JOIN JOGA j 
		ON p.TIME1 = j.TIME1 
		AND p.TIME2 = j.TIME2
		AND (EXTRACT (MONTH FROM p."DATA") BETWEEN 1 AND 2)
		WHERE j.CLASSICO IS NOT NULL
	GROUP BY j.CLASSICO;