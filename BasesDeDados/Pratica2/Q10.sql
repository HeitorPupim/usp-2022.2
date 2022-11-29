-- Q10: (X) Selecionar times que nunca jogaram em São Carlos e em Belo Horizonte.	

      	SELECT * FROM partida; -- carrega LOCAL
      	--precisamos verificar os times que jogaram em São Carlos e BH
      	SELECT p.TIME1, p.TIME2 FROM PARTIDA p 
      		WHERE p."LOCAL" IN ('SAO CARLOS', 'BELO HORIZONTE');
						
  		-- selecionando todas as partidas em que os times não jogaram em sanca ou bh:
      	SELECT * 
  			FROM PARTIDA p 
  				WHERE (p.TIME1, p.TIME2) NOT IN (SELECT p.TIME1, p.TIME2 FROM PARTIDA p 
      										WHERE p."LOCAL" IN ('SAO CARLOS', 'BELO HORIZONTE'));		