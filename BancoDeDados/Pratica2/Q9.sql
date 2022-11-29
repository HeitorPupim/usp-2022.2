--Q9: X
       -- modo 1: pior desempenho
      SELECT * FROM PARTIDA p WHERE 
      	p.TIME1 IN  (SELECT nome FROM "TIME" t
      						WHERE t.ESTADO = 'SP')
      	OR 
      	p.TIME2 IN (SELECT nome FROM "TIME" t
      						WHERE t.ESTADO = 'SP');
      		
      	-- modo 2: left join e where desnecessarios
      	SELECT DISTINCT p.TIME1, p.TIME2 ,p.PLACAR, p."DATA" FROM PARTIDA p
      		LEFT JOIN "TIME" t ON t.ESTADO = 'SP' AND (t.NOME = p.TIME1 OR t.nome = p.TIME2)
      		WHERE t.nome IS NOT NULL
      		ORDER BY p."DATA" ASC ;
      	
      	--modo 3: melhor desempenho
      	SELECT p.TIME1, p.TIME2 FROM PARTIDA p 
      		JOIN "TIME" t ON (t.NOME = p.TIME1 OR t.NOME = p.TIME2) AND t.ESTADO = 'SP'
      		ORDER BY p."DATA" ASC;