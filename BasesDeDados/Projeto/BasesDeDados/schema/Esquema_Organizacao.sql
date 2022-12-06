-- Criar Tabelas:
create table organizacao(
	cnpj bigint not null, --14 digitos
	nome varchar(20) not null, 
	regiao varchar(20) not null,
	pontuacao int,
	constraint pk_organizacao primary key (cnpj)
);


create table beneficio (
	nome varchar(20) not null,
	data date not null,
	destino int not null,
	constraint pk_beneficio primary key(nome, data),
	constraint fk_beneficio foreign key(destino) references organizacao(cnpj) on delete cascade,
	constraint beneficio_data check(data <= current_date) --checa se a data do benefício é menor ou igual a data atual
);


create table pessoa_carente(
	cpf bigint not null,
	nome varchar(20),
	constraint pk_pessoa_carente primary key (cpf)
);


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

create table organizador(
	cpf bigint not null,
	setor varchar(15) not null,
	constraint pk_organizador primary key(cpf),
	constraint fk_organizador foreign key(cpf) references voluntario(cpf)
);

create table cozinheiro(
	cpf bigint not null,
	posicao_cozinha varchar(15), --limpeza,chefe,etc...
	constraint pk_cozinheiro primary key(cpf),
	constraint fk_cozinheiro foreign key(cpf) references voluntario(cpf)
);

create table doador(
    cpf_cnpj bigint not null,
    nome varchar(20),
    constraint pk_doador primary key(cpf_cnpj)
);

create table doacao(
    doador bigint not null,
    dia_hora timestamp not null,
    tipo varchar(20) not null, -- fazer check com 'alimento/dinheiro'
    organizacao bigint not null,
    constraint pk_doacao primary key(doador, dia_hora),
    constraint fk_doacao foreign key(organizacao) references organizacao(cnpj)
);

create table alimento(
    doador bigint not null,
    dia_hora timestamp not null,
    nome varchar(20) not null,
    quantidade int not null,
    categoria varchar(20) not null,
    constraint pk_alimento primary key(doador, dia_hora),
    constraint fk_alimento foreign key(doador, dia_hora) references doacao(doador, dia_hora) on delete cascade
);

create table dinheiro(
    doador bigint not null,
    dia_hora timestamp not null,
    valor float,
    constraint pk_dinheiro primary key(doador, dia_hora),
    constraint fk_dinheiro foreign key(doador, dia_hora) references doacao(doador, dia_hora) on delete cascade
);

create table equipamento(
    nome varchar(20) not null,
    constraint pk_equipamento primary key(nome)
);

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


create table refeicao(
	data date not null,
	nome varchar(20) not null,
	quantidade int not null,
	constraint pk_refeicao primary key (data, nome)
);


create table cozinheiro_refeicao(
	cpf bigint not null,
	data date not null,
	nome varchar(20) not null,
	constraint pk_cozinheiro_refeicao primary key (cpf,data,nome),
	constraint fk_cozinheiro_refeicao foreign key (cpf) references cozinheiro(cpf),
	constraint fk_cozinheiro_refeicao_2 foreign key (data,nome) references refeicao(data,nome)
);


create table alimento_refeicao(
	doador bigint not null,
	dia_hora timestamp not null,
	data date not null,
	nome varchar(20) not null,
	constraint pk_alimento_refeicao primary key(doador,dia_hora,data,nome),
	constraint fk_alimento_refeicao1 foreign key(doador, dia_hora) references alimento(doador, dia_hora) on delete set null,
	constraint fk_alimento_refeicao2 foreign key (data, nome) references refeicao(data,nome)
);

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


-- 
alter table voluntario
	add constraint fk_voluntario_organizador foreign key(organizador) references organizador(cpf)
	add constraint ck_voluntario_hora_trabalho 
        check (upper(hora_trabalho) in ('DIURNO', 'NOTURNO'));

alter table cozinheiro
    add constraint ck_cozinheiro_posicao_cozinha 
        check (upper(posicao_cozinha) in ('LIMPEZA', 'CHEFE', 'ASSISTENTE', 'APRENDIZ'))
;

alter table doacao
    add constraint ck_doacao_tipo
        check (upper(tipo) in ('ALIMENTO', 'DINHEIRO')) 
;

alter table alimento
    add  constraint ck_alimento_categoria
        check (upper(categoria) in ('PERECIVEL', 'NAOPERECIVEL'))
;

alter table alimento_refeicao 
    add constraint ck_alimento_refeicao_data check (data >= dia_hora);

alter table recebe 
    drop constraint pk_recebe,
    add constraint pk_recebe primary key (organizacao, pessoa_carente, data, nome, data_entrega);
