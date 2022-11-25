
--PRATICA 2:

-- TESTE SOBRE OTIMIZADOR DE RECURSOS:

--A) A coluna usada é a "NOME", é uma chave única (PK). O nome do índice é PK_TIME. O indice é de chave única.

--B) Executado

EXEC DBMS_STATS.GATHER_SCHEMA_STATS(NULL, NULL);

--C)  Pq em alguns casos é necessário fazer a verificação dos dados das colunas. Nesse caso o LIKE utiliza o comparador de strings, dai no caso em que a string começ com uma sequencia definida, ele consegue acessar como índice.

EXPLAIN PLAN FOR
select * from time where nome = 'INTER'; 
SELECT plan_table_output
FROM TABLE(dbms_xplan.display());
-------------------------------------------------------------------------------------------
EXPLAIN PLAN FOR
select * from time where upper(nome) = 'INTER'; 
SELECT plan_table_output
FROM TABLE(dbms_xplan.display());
-------------------------------------------------------------------------------------------
EXPLAIN PLAN FOR
select * from time where nome like 'IN%'; 
SELECT plan_table_output
FROM TABLE(dbms_xplan.display());
-------------------------------------------------------------------------------------------
EXPLAIN PLAN FOR
select * from time where nome like '%TER'; 
SELECT plan_table_output
FROM TABLE(dbms_xplan.display());


-- Exercicio:
--Q1: V
select * from partida
    where local = 'SANTOS' ;
    
--Q2: V
select to_char(data, 'dd-mm-yyyy hh24:mi') as data, local 
    from partida where
    time1 = 'PALMEIRAS'
    or time2 = 'PALMEIRAS';
    
-- Q3: V
select * from jogador j, time t;

select j.cpf, j.nome, round((sysdate - j.data_nasc)/365) as idade,
    t.nome as time, t.estado as estado_time 
        from jogador j
         left join time t on t.nome = j.time;
    
--Q4: V
    --1)
    select j.cpf, j.nome, j.data_nasc, t.nome from jogador j, time t 
        where j.time = t.nome
            and t.estado = 'SP';
    
    --2)
    select j.cpf, j.nome, j.data_nasc, t.nome from jogador j
        join time t on t.nome = j.time
        where t.estado = 'SP';
         
--Q6: V 
    select p.time1, p.time2, p.data, p.placar,j.classico from partida p 
        join joga j on j.time1 = p.time1
         where p.local = 'SANTOS';
    
--Q7: V 
	SELECT t.NOME, t.ESTADO
	FROM JOGA j 
	JOIN "TIME" t ON t.NOME = j.TIME1 OR t.NOME = j.TIME2 
	WHERE j.CLASSICO = 'S';
            
-- Q8: 
    select t.nome, u.cor_principal from uniforme u
        join time t on t.nome = u.time
        where t.estado = 'MG' 
        and u.tipo = 'TITULAR';
    
        
--Q9: X
       -- modo 1:
      SELECT * FROM PARTIDA p WHERE 
      	p.TIME1 IN  (SELECT nome FROM "TIME" t
      						WHERE t.ESTADO = 'SP')
      	OR 
      	p.TIME2 IN (SELECT nome FROM "TIME" t
      						WHERE t.ESTADO = 'SP');
      		
      	-- modo 2: 	
      	SELECT DISTINCT p.TIME1, p.TIME2 ,p.PLACAR, p."DATA" FROM PARTIDA p
      		LEFT JOIN "TIME" t ON t.ESTADO = 'SP' AND (t.NOME = p.TIME1 OR t.nome = p.TIME2)
      		WHERE t.nome IS NOT NULL
      		ORDER BY p."DATA" ASC ;
      	
-- Q10: (X) Selecionar times que nunca jogaram em São Carlos e em Belo Horizonte.	
  SELECT * FROM "TIME" t 
  	JOIN PARTIDA p ON t.NOME = p.TIME1 OR t.NOME = p.TIME2
	  	WHERE p."LOCAL" NOT IN  ('SAO CARLOS', 'BELO HORIZONTE')
	  	ORDER BY p."DATA" asc;
  
  SELECT * FROM time;
  SELECT * FROM partida
 	ORDER BY DATA ASC;
 
 SELECT * FROM "TIME" t 
 	WHERE EXISTS ((SELECT p.TIME1, p.TIME2 FROM PARTIDA p WHERE p."LOCAL" NOT IN ('BELO HORIZONTE', 'SAO CARLOS')));
 
 
SELECT * FROM time;	    

		
-- PRATICA 3:
--Q1: V 
select t.nome, t.estado from uniforme u 
    left join time t on u.time = t.nome
    where cor_principal is null and u.tipo = 'TITULAR';

--Q2: V 
select 
    j.nome, 
    j.data_nasc, 
    j.time, 
    p.data,
    p.local,
    jo.classico
        from jogador j
        join partida p  on j.time = p.time1 or j.time = p.time2
        join joga jo on jo.time1 = p.time1 and jo.time2 = p.time2
        --where classico is not null
        order by p.data asc;

--Q3: V
select time.nome, time.estado, diretor.nome as diretor_time from time
    left join diretor on time.nome = diretor.time;


--Q4: V
    
SELECT COUNT(p.TIME1) AS partidas, j.classico FROM PARTIDA p
RIGHT JOIN JOGA j 
		ON p.TIME1 = j.TIME1 
		AND p.TIME2 = j.TIME2
		AND (EXTRACT (MONTH FROM p."DATA") BETWEEN 1 AND 2)
		WHERE j.CLASSICO IS NOT NULL
	GROUP BY j.CLASSICO;

--Q5: V
select extract(month from data) as mes_partida, count(*) as contagem from partida
    left join joga on partida.time1 = joga.time1 and partida.time2 = joga.time2
    --where joga.classico = 'S'
    where extract(year from data) = 2018 and joga.classico = 'S'
    group by extract(month from data)
    order by CONTAGEM DESC;

--Q6: X  Para cada time, selecionar: nome, estado, saldo de gols, e a quantidade de jogos clássicos que jogou por ano, considerando apenas anos em que o time jogou alguma partida (clássica ou não).
SELECT t.NOME, t.ESTADO, t.SALDO_GOLS FROM "TIME" t;

SELECT EXTRACT(YEAR FROM p.DATA) AS data_jogo, p.time1,count(p.TIME1)
FROM PARTIDA  p 
JOIN JOGA j ON p.TIME1 = j.TIME1 AND p.TIME2 = j.TIME2
GROUP BY EXTRACT(YEAR FROM p."DATA"), p.time1
ORDER BY DATA_JOGO ASC;
;



SELECT * FROM PARTIDA p 
	JOIN JOGA j ON p.TIME1 = j.TIME1 AND p.TIME2 = j.TIME2
	LEFT JOIN "TIME" t ON p.TIME1=t.NOME OR p.TIME2 = t.NOME;


--Q7: X

SELECT * FROM "TIME" t 
	WHERE t.TIPO = 'PROFISSIONAL';



SELECT COUNT(p.TIME1) AS numpartidas, p.TIME1, p.PLACAR FROM PARTIDA p 
	JOIN "TIME" t ON t.NOME = p.TIME1 AND t.TIPO = 'PROFISSIONAL'
	WHERE p.PLACAR LIKE '0%'
	GROUP BY p.TIME1, p.PLACAR;

SELECT count(p.time2) AS numpartidas, p.TIME2, p.PLACAR FROM PARTIDA p 
	JOIN "TIME" t ON t.NOME = p.TIME2 AND t.TIPO = 'PROFISSIONAL'
	WHERE (p.PLACAR LIKE '%X0')
	GROUP BY p.TIME2, p.PLACAR;
   
   
   
--Q8:

	SELECT t.ESTADO, 
	COUNT(t.NOME),
	SUM(t.SALDO_GOLS) AS soma
	FROM "TIME" t
	GROUP BY t.ESTADO;

   
   