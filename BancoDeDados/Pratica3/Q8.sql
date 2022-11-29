--Q8: V

	SELECT t.ESTADO, t.TIPO , COUNT(t.NOME) AS contagem, avg(t.SALDO_GOLS) AS media_gols
	FROM "TIME" t
	WHERE t.ESTADO IS NOT NULL
	GROUP BY t.ESTADO, t.TIPO 
	ORDER BY t.ESTADO, t.TIPO ;
