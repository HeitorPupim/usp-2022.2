--1) busca a organizacao com mais pontos e a quantidade de voluntarios dela
select o.cnpj, o.nome, count(v.cpf) as quantidade_voluntarios, o.pontuacao 
    from organizacao o join voluntario v on o.cnpj = v.organizacao 
    where (o.pontuacao = (select max(o2.pontuacao) from organizacao o2))
    group by o.cnpj, o.nome;

--busca todas as organizacoes e a quantidade de voluntarios dela
select o.cnpj, o.nome, count(v.organizacao) as quantidade_voluntarios
    from organizacao o left join voluntario v on o.cnpj = v.organizacao 
    group by o.cnpj, o.nome 
    order by o.cnpj;
--*********************************** ATUALIZAÇÃO ***********************************
    --dividir em 2:
    --2) quantos cozinheiros tem pela organização
    select o.cnpj, o.nome, count(c.posicao_cozinha) as qtde_cozinheiros
    from organizacao o left join voluntario v on o.cnpj = v.organizacao 
    left join cozinheiro c on v.cpf= c.cpf
    group by o.cnpj,o.nome   
    order by o.cnpj;
    -- 3) quantos organizadores tem por organização
    select o.cnpj, o.nome, count(c.setor) as quantidade_organizador
    from organizacao o left join voluntario v on o.cnpj = v.organizacao 
    left join organizador c on v.cpf= c.cpf
    group by o.cnpj,o.nome   
    order by o.cnpj;


--4) busca os alimentos que foram utilizados em alguma refeicao
select d.doador, d.dia_hora as dia_doacao, a.nome, ar.nome, ar.data as dia_preparo
    from alimento a join doacao d on a.doador = d.doador and
                         a.dia_hora = d.dia_hora and 
                         upper(d.tipo) = 'ALIMENTO' 
    join alimento_refeicao ar on d.doador = ar.doador and
                                 d.dia_hora = ar.dia_hora
    group by ar.nome, a.nome, d.doador, d.dia_hora, ar.data 
    order by ar.nome, a.nome;

--5) busca todas as pessoas carentes e quantas refeicoes cada uma recebeu em cada organizacao
select pc.cpf, pc.nome, sum(r.quantidade) as total_refeicoes, r.organizacao
    from organizacao o join recebe r on o.cnpj = r.organizacao 
    right join pessoa_carente pc on pc.cpf = r.pessoa_carente 
    group by pc.cpf, pc.nome, r.organizacao
    order by pc.cpf, r.organizacao;
