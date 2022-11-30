-- Q10: (X) Selecionar times que nunca jogaram em São Carlos e em Belo Horizonte
	--select times que jogaram em sanca e bh
      	SELECT * FROM PARTIDA p 
      		WHERE p."LOCAL" IN ('SAO CARLOS', 'BELO HORIZONTE');
      	
      	
  	-- selecionar todos menos os times que estão na query acima:
      	SELECT * FROM "TIME" t 
      		WHERE NOT EXISTS 
      			(SELECT * FROM PARTIDA p 
 		     		WHERE p."LOCAL" IN ('SAO CARLOS', 'BELO HORIZONTE')
 		     			AND (p.TIME1 = t.NOME OR p.TIME2 = t.NOME));
