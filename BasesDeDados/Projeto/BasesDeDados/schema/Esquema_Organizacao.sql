-- Criar Tabelas:

--ORGANIZACAO
create table organizacao(
	cnpj bigint not null, --14 digitos
	nome varchar(20) not null, 
	regiao varchar(20) not null,
	pontuacao int,
	constraint pk_organizacao primary key (cnpj)
);

--BENEFCIO
create table beneficio (
	nome varchar(20) not null,
	data date not null,
	destino int not null,
	constraint pk_beneficio primary key(nome, data),
	constraint fk_beneficio foreign key(destino) references organizacao(cnpj) on delete cascade,
	constraint beneficio_data check(data <= current_date) --checa se a data do benefício é menor ou igual a data atual
);

--PESSOA CARENTE
create table pessoa_carente(
	cpf bigint not null,
	nome varchar(20),
	constraint pk_pessoa_carente primary key (cpf)
);

-- VOLUNTARIO
create table voluntario(
	cpf bigint not null,
	rg bigint not null,
	residencia varchar(20),
	telefone bigint,
	hora_trabalho varchar(7), --noturno/diurno
	tempo_contribuicao interval day, --testar inserção do dia
	organizador bigint,
	organizacao bigint not null,
	constraint pk_voluntario primary key(cpf),
	constraint uk_volunatrio unique(rg),
	constraint fk_voluntario foreign key(organizacao) references organizacao(cnpj) on delete cascade,
	constraint check_hora_trabalho check(hora_trabalho in ('NOTURNO', 'DIURNO'))
	--criar alter table foreing key voluntario(organizador) -> organizador(cpf) 
);

-- ORGANIZADOR
create table organizador(
	cpf bigint not null,
	setor varchar(15) not null,
	constraint pk_organizador primary key(cpf),
	constraint fk_organizador foreign key(cpf) references voluntario(cpf)
);

-- COZINHEIRO
create table cozinheiro(
	cpf bigint not null,
	posicao_cozinha varchar(15), --limpeza,chefe,etc...
	constraint pk_cozinheiro primary key(cpf),
	constraint fk_cozinheiro foreign key(cpf) references voluntario(cpf)
);

-- DOADOR
create table doador(
    cpf_cnpj bigint not null,
    nome varchar(20),
    constraint pk_doador primary key(cpf_cnpj)
);

-- DOACAO
create table doacao(
    doador bigint not null,
    dia_hora timestamp not null,
    tipo varchar(20) not null, -- fazer check com 'alimento/dinheiro'
    organizacao bigint not null,
    constraint pk_doacao primary key(doador, dia_hora),
    constraint fk_doacao foreign key(organizacao) references organizacao(cnpj)
);

-- ALIMENTO
create table alimento(
    doador bigint not null,
    dia_hora timestamp not null,
    nome varchar(20) not null,
    quantidade int not null,
    categoria varchar(20) not null,
    constraint pk_alimento primary key(doador, dia_hora),
    constraint fk_alimento foreign key(doador, dia_hora) references doacao(doador, dia_hora) on delete cascade
);

-- DINHEIRO
create table dinheiro(
    doador bigint not null,
    dia_hora timestamp not null,
    valor float,
    constraint pk_dinheiro primary key(doador, dia_hora),
    constraint fk_dinheiro foreign key(doador, dia_hora) references doacao(doador, dia_hora) on delete cascade
);

-- EQUIPAMENTO
create table equipamento(
    nome varchar(20) not null,
    constraint pk_equipamento primary key(nome)
);

-- COMPRA
create table compra(
	doador bigint not null,
    dia_hora timestamp not null,
    nome varchar(20) not null,
   	valor float not null,
   	quantidade int not null,
   	constraint pk_compra primary key (doador,dia_hora, nome),
   	constraint fk_compra foreign key (doador, dia_hora) references dinheiro(doador,dia_hora) on delete set null,
	constraint fk_compra_nome_equipamento foreign key (nome) references equipamento(nome) on delete no action
);

-- REFEICAO
create table refeicao(
	data date not null,
	nome varchar(20) not null,
	quantidade int not null,
	constraint pk_refeicao primary key (data, nome)
);

-- COZINHEIRO_REFEICAO
create table cozinheiro_refeicao(
	cpf bigint not null,
	data date not null,
	nome varchar(20) not null,
	constraint pk_cozinheiro_refeicao primary key (cpf,data,nome),
	constraint fk_cozinheiro_refeicao foreign key (cpf) references cozinheiro(cpf),
	constraint fk_cozinheiro_refeicao_2 foreign key (data,nome) references refeicao(data,nome)
);

-- ALIMENTO_REFEICAO
create table alimento_refeicao(
	doador bigint not null,
	dia_hora timestamp not null,
	data date not null,
	nome varchar(20) not null,
	constraint pk_alimento_refeicao primary key(doador,dia_hora,data,nome),
	constraint fk_alimento_refeicao1 foreign key(doador, dia_hora) references alimento(doador, dia_hora) on delete set null,
	constraint fk_alimento_refeicao2 foreign key (data, nome) references refeicao(data,nome)
);

-- RECEBE
create table recebe(
	organizacao bigint not null,
	pessoa_carente bigint not null,
	data date not null, 
	nome varchar(20) not null,
	quantidade int not null,
	data_entrega date not null,
	constraint pk_recebe primary key(organizacao, pessoa_carente, data, nome),
	constraint fk_recebe_pessoa_carente foreign key (pessoa_carente) references pessoa_carente(cpf),
	constraint fk_recebe_organizacao foreign key (organizacao) references organizacao(cnpj),
	constraint fk_recebe_data_nome foreign key (data,nome) references refeicao(data,nome)
);


--Alter Tables:

-- tabela voluntário necessitava de uma chave estrangeira para a tabela organizador
alter table voluntario
	add constraint fk_voluntario_organizador foreign key(organizador) references organizador(cpf)
	add constraint ck_voluntario_hora_trabalho 
        check (upper(hora_trabalho) in ('DIURNO', 'NOTURNO'));

-- tabela cozinheiro precisava checar se a posição na cozinha era válida
alter table cozinheiro
    add constraint ck_cozinheiro_posicao_cozinha 
        check (upper(posicao_cozinha) in ('LIMPEZA', 'CHEFE', 'ASSISTENTE', 'APRENDIZ'))
;

-- tabela doação precisava checar se o tipo era válido
alter table doacao
    add constraint ck_doacao_tipo
        check (upper(tipo) in ('ALIMENTO', 'DINHEIRO')) 
;

-- tabela alimento precisava checar se a categoria era válida
alter table alimento
    add  constraint ck_alimento_categoria
        check (upper(categoria) in ('PERECIVEL', 'NAOPERECIVEL'))
;

-- tabela alimento_refeicao precisava cehcar se a data era maior ou igual a data da doação
alter table alimento_refeicao 
    add constraint ck_alimento_refeicao_data check (data >= dia_hora);

-- tabela recebe precisava de uma primary key composta
alter table recebe 
    drop constraint pk_recebe,
    add constraint pk_recebe primary key (organizacao, pessoa_carente, data, nome, data_entrega);
