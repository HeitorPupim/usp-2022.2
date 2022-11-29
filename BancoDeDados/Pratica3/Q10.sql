--Q10: V
	
	--INSERINDO TUPLA PARA VERIFICAR 
	INSERT INTO PARTIDA(TIME1, TIME2, "DATA", PLACAR, "LOCAL")
	VALUES ('INTER', 'CHAPECOENSE', TO_DATE('2018-02-01', 'YYYY-MM-DD'), '0X0', 'BELO HORIZONTE');
	INSERT INTO PARTIDA(TIME1, TIME2, "DATA", PLACAR, "LOCAL")
	VALUES ('INTER', 'PALMEIRAS', TO_DATE('2018-02-01', 'YYYY-MM-DD'), '0X0', 'BELO HORIZONTE');
	
	--locais em que o santos jogou:
	SELECT p."LOCAL" FROM PARTIDA p
		WHERE (p.TIME1 = 'SANTOS' OR p.TIME2 = 'SANTOS')
			AND p."LOCAL" IS NOT NULL;
		
	--FAZENDO A DIVISAO COM NOT EXISTS E MINUS
	SELECT t.nome
		FROM time t
		WHERE estado = 'SP' AND nome != 'SANTOS'
		AND
		NOT EXISTS (
    				(SELECT local 
    					FROM partida 
    					WHERE (time1 = 'SANTOS' OR time2 = 'SANTOS') AND local IS NOT NULL)
    		MINUS
    				(SELECT local 
    					FROM partida 
    					WHERE time1 = t.nome OR time2 = t.nome)
					);