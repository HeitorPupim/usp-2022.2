--inserir dados nas tabelas:

--ORGANIZACAO:
insert into organizacao(cnpj, nome, regiao, pontuacao)
values(1, 'CASA DA SOPA', 'CENTRO', 30);
insert into organizacao(cnpj, nome, regiao, pontuacao)
values(2, 'ONG SANCA', 'JARDIM LUFTFALLA', 43);
insert into organizacao(cnpj, nome, regiao, pontuacao)
values(3, 'AMIGOS DO JARIDM', 'CIDADE JARDIM', 12);

-- BENEFICIO
insert into BENEFICIO(NOME,data,DESTINO)
values('TV 20 POLEGADAS', '2021-11-23', 2);
insert into BENEFICIO(NOME,data,DESTINO)
values('PRODUTO LIMPEZA', '2021-10-12', 1);
insert into BENEFICIO(NOME,data,DESTINO)
values('PANELAS TRAMONTINA', '2021-01-23', 3);
insert into BENEFICIO(NOME,data,DESTINO)
values('COIFA COZINHA', '2021-04-11', 1);


-- PESSOA_CARENTE:
insert into pessoa_carente(cpf,nome)
values(12, 'ROGERIO DUARTE');
insert into pessoa_carente(cpf,nome)
values(123, 'CARLOS MENEZES');
insert into pessoa_carente(cpf,nome)
values(10, 'MENINO NEY');
insert into pessoa_carente(cpf,nome)
values(42, 'KUNG LAO');
insert into pessoa_carente(cpf,nome)
values(1, 'LIU KANG');
insert into pessoa_carente(cpf,nome)
values(99, 'ISHOWSPEED');
insert into pessoa_carente(cpf,nome)
values(92, 'GUILHERME');
insert into pessoa_carente(cpf)
values(492 );

--VOLUNTARIO / ORGANIZADOR
insert into voluntario(cpf, rg, residencia, telefone, hora_trabalho, organizacao)
values (1, 421, 'JARDIM EUCLIDES', 3385, 'DIURNO', 1);
insert into voluntario(cpf, rg, residencia, telefone, hora_trabalho, organizacao)
values (4, 81283, 'AVENIDA PAULISTA', 13132, 'NOTURNO', 1);
insert into voluntario(cpf, rg, residencia, telefone, hora_trabalho, organizacao)
values (5, 8123, 'BERRINI', 331231, 'NOTURNO', 3);
insert into organizador(CPF, setor)
values (1, 'COZINHA');
insert into voluntario(cpf, rg, residencia, telefone, hora_trabalho, organizador, organizacao)
values (3, 1231, 'JARDIM EUCLIDES', 3385, 'DIURNO', 1, 1);
insert into organizador(CPF, setor)
values (3, 'LIMPEZA')
-- COZINHEIRO
insert into COZINHEIRO (CPF, POSICAO_COZINHA)
VALUES(4, 'CHEFE');
insert into COZINHEIRO (CPF, POSICAO_COZINHA)
VALUES(5, 'APRENDIZ');
--DOADOR
insert into DOADOR (CPF_CNPJ, NOME)
values (11, 'MAGALU');
insert into DOADOR (CPF_CNPJ, NOME)
values (22, 'RONALDO FENOMENO');
insert into DOADOR (CPF_CNPJ, NOME)
values (44, 'GLOBO');
insert into DOADOR (CPF_CNPJ, NOME)
values (33, 'ROBERTO');
insert into DOADOR (CPF_CNPJ)
values (55);


--DOACAO
inseRt into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-01-03 12:50', 'ALIMENTO', 1);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-12-03 18:50', 'DINHEIRO', 1);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (22, '2021-01-03 12:50', 'DINHEIRO', 2);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (33, '2021-07-04 12:42', 'ALIMENTO', 3);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (44, '2021-09-03 12:50', 'ALIMENTO', 3);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (55, '2021-10-11 11:30', 'ALIMENTO', 2);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-10-11 11:30', 'ALIMENTO', 2);
insert into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-10-11 11:40', 'ALIMENTO', 2);
inseRt into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-01-03 20:00', 'DINHEIRO', 3);
inseRt into doacao(doador,dia_hora,tipo,organizacao)
values (11, '2021-01-03 10:00', 'DINHEIRO', 3);


--ALIMENTO:

insert into ALIMENTO(DOADOR, DIA_HORA, NOME, QUANTIDADE, CATEGORIA)
VALUES(11, '2021-01-03 12:50', 'ARROZ', 2, 'NAOPERECIVEL');
insert into ALIMENTO(DOADOR, DIA_HORA, NOME, QUANTIDADE, CATEGORIA)
VALUES(22, '2021-01-03 12:50', 'FEIJAO', 2, 'NAOPERECIVEL');
insert into ALIMENTO(DOADOR, DIA_HORA, NOME, QUANTIDADE, CATEGORIA)
VALUES(44, '2021-09-03 12:50', 'FEIJAO', 2, 'NAOPERECIVEL');
insert into ALIMENTO(DOADOR, DIA_HORA, NOME, QUANTIDADE, CATEGORIA)
VALUES(11, '2021-10-11 11:30', 'MACARRAO', 3, 'NAOPERECIVEL');
insert into ALIMENTO(DOADOR, DIA_HORA, NOME, QUANTIDADE, CATEGORIA)
VALUES(11, '2021-10-11 11:30', 'FEIJAO', 5, 'NAOPERECIVEL');

--DINHEIRO
insert into DINHEIRO(DOADOR, DIA_HORA, VALOR)
VALUES(11, '2021-01-03 12:50', 1000);
insert into DINHEIRO(DOADOR, DIA_HORA, VALOR)
VALUES(22, '2021-01-03 12:50', 25);
insert into DINHEIRO(DOADOR, DIA_HORA, VALOR)
VALUES(11, '2021-01-03 20:00', 600);
insert into DINHEIRO(DOADOR, DIA_HORA, VALOR)
VALUES(11, '2021-01-03 10:00', 400);

--EQUIPAMENTO:
insert into EQUIPAMENTO (NOME)
VALUES('RADIO');
insert into EQUIPAMENTO (NOME)
VALUES('VUVUZELA');
insert into EQUIPAMENTO (NOME)
VALUES('ROUPA');
insert into EQUIPAMENTO (NOME)
VALUES('CONE');

--COMPRA
insert into COMPRA(DOADOR,DIA_HORA,NOME, VALOR, QUANTIDADE)
values(11, '2021-01-03 12:50', 'CONE', 42, 3);
insert into COMPRA(DOADOR,DIA_HORA,NOME, VALOR, QUANTIDADE)
values(11, '2021-01-03 12:50', 'VUVUZELA', 24, 3);

--REFEICAO
insert into REFEICAO(data, NOME, QUANTIDADE)
VALUES('21-11-2021', 'FEIJOADA', 30);
insert into REFEICAO(data, NOME, QUANTIDADE)
VALUES('21-11-2021', 'MACARRONADA', 299)

--ALIMENTO REFEICAO
insert into COZINHEIRO_REFEICAO(CPF,data,NOME)
VALUES(4, '21-11-2021', 'FEIJOADA');
insert into COZINHEIRO_REFEICAO(CPF,data,NOME)
VALUES(4, '21-11-2021', 'MACARRONADA');

--ALIMENTO_REFEICAO
insert into ALIMENTO_REFEICAO(DOADOR,DIA_HORA,data,NOME)
values (11, '2021-01-03 12:50','21-11-2021', 'FEIJOADA');
insert into ALIMENTO_REFEICAO(DOADOR,DIA_HORA,data,NOME)
values (11, '2021-01-03 12:50','21-11-2021', 'MACARRONADA');

-- RECEBE
insert into RECEBE (ORGANIZACAO,PESSOA_CARENTE,data,NOME,QUANTIDADE,DATA_ENTREGA)
VALUES(1,12, '21-11-2021', 'FEIJOADA', 2, '22-11-2021')
insert into RECEBE (ORGANIZACAO,PESSOA_CARENTE,data,NOME,QUANTIDADE,DATA_ENTREGA)
VALUES(1,123, '21-11-2021', 'FEIJOADA', 2, '22-11-2021')
insert into RECEBE (ORGANIZACAO,PESSOA_CARENTE,data,NOME,QUANTIDADE,DATA_ENTREGA)
VALUES(2,12, '21-11-2021', 'MACARRONADA', 1, '23-11-2021')
insert into RECEBE (ORGANIZACAO,PESSOA_CARENTE,data,NOME,QUANTIDADE,DATA_ENTREGA)
VALUES(1,12, '21-11-2021', 'FEIJOADA', 3, '26-11-2021')