import time


def printHello():
   print("-"*60 + "\n")
   print("Carregando sistema...")
   print("-"*60)
   print("*"*60)
   time.sleep(1) 
   print("-"*60 + "\n")
   print("Sistema carregado com sucesso!")
   print("-"*60 + "\n")
   print("-"*60 + "\n")
   print("Bem vindo!\n")
   time.sleep(1)   

def printHeader():
   print("Escolha uma das opções abaixo:")
   print("-"*60)
   print("1 - Listar Organizações")
   print("2 - Inserir Organização")
   print("3 - Atualizar Organização")
   print("4 - Deletar Organização")
   print("5 - Inserir Voluntário")
   print("6 - Buscar Organização e a quantidade de voluntários")
   print("7 - Buscar Organização e a quantidade de voluntários por horário de trabalho")
   print("8 - Buscar Quantidade de Cozinheiros por Organização")
   print("9 - Buscar Quantidade de Organizadores por Organização")
   print("0 - Sair")
   print("-"*60)
            
def getOption():
   opcao = int(input("Digite a opção desejada: "))
   print("-"*60)
   return opcao

def insertOrganizacao(sis):
   print("Insira os dados da organização que deseja inserir:")
   cnpj = int(input("CNPJ: "))
   nome = input("Nome da Organização: ")
   regiao = input("Região: ")
   pontuacao = int(input("Pontuação: "))
   sql = f"""insert into organizacao(cnpj, nome, regiao, pontuacao) values({cnpj},'{nome}','{regiao}',{pontuacao});"""
   sis.execute_sql(sql)
   sis.commit()
   print("Organização inserida com sucesso!")
   
def insertVoluntario(sis):
   print("Insira os dados do voluntário que deseja inserir:")
   cpf = int(input("CPF: "))
   rg = int(input("RG do Voluntário: "))
   residencia = (input("Residencia: "))
   telefone = int(input("Telefone: "))
   hora_trabalho = input("Horário de trabalho (deve ser DIURNO ou NOTURNO): ").upper()
   tempo_contribuicao = input("Tempo de Contribuicao: ")
   organizador = int(input("CPF do organizador responsavel:"))
   organizacao = int(input("CNPJ da organização: "))
   sql = f"""insert into voluntario(cpf, rg, residencia, telefone, hora_trabalho, tempo_contribuicao, organizador, organizacao) 
            values(
               {cpf},
               {rg},'{residencia}',
               {telefone},'{hora_trabalho}','{tempo_contribuicao}',{organizador},{organizacao});"""
   sis.execute_sql(sql)
   sis.commit()
   print("Voluntário inserido com sucesso!")
   
def updateOrganizacao(sis):
   cnpj = int(input("Insira o CNPJ da organização que deseja atualizar:"))
   sql = f"""select * from organizacao where cnpj = {cnpj};"""
   sis.execute_sql(sql)
   print("-"*60)
   print("Tabela antes da atualização:\n")
   sis.showTable()
   print("-"*60)
   print("Qual campo deseja atualizar?")
   print("  1 - Nome")
   print("  2 - Região")
   print("  3 - Pontuação")
   print("  0 - Voltar")
   print("-"*60)
   campo = int(input("Digite a opção desejada: "))
   #  Opção de voltar
   if campo == 0:
      print("-"*60)
      print("Voltando...")
      print("-"*60)
      printHeader()
      selectOption(getOption(), sis)
      return
   
   # Atualização do nome
   elif campo == 1:
      novo_nome = input("Insira o novo nome: ")
      sql = f"""update organizacao set nome = '{novo_nome}' where cnpj = {cnpj};"""
      sis.execute_sql(sql)
   
   # Atualização da região
   elif campo == 2:
      nova_regiao = input("Insira a nova região: ")
      sql = f"""update organizacao set regiao = '{nova_regiao}' where cnpj = {cnpj};"""
      sis.execute_sql(sql)
   
   # Atualização da pontuação
   elif campo == 3:
      nova_pontuacao = int(input("Insira a nova pontuação: "))
      sql = f"""update organizacao set pontuacao = {nova_pontuacao} where cnpj = {cnpj};"""
      sis.execute_sql(sql)
   # Operação inválida.
   else:    
      print("-"*60)
      print("Opção inválida! Tente novamente.")
      print("-"*60)
      updateOrganizacao(getOption(), sis)
      return
   
   print("Tabela após a atualização:")
   print("-"*60)
   sql = f"""select * from organizacao where cnpj = {cnpj};"""
   sis.execute_sql(sql)
   sis.showTable()
   #commit no banco após uma atualização.
   sis.commit()   

def showOrganizacao(sis):
   sis.execute_sql("select * from organizacao order by cnpj asc;")
   sis.showTable()

def deleteOrganizacao(sis):
   print("Organizações cadastradas:")
   print("-"*60)
   showOrganizacao(sis)
   print("-"*60)
   cnpj = int(input("Insira o CNPJ da organização que deseja deletar: "))
   sql = f"""delete from organizacao where cnpj = {cnpj};"""
   sis.execute_sql(sql)
   sis.commit()
   time.sleep(1)
   print("-"*60)
   print("Organização deletada com sucesso!")
   print("-"*60)
   time.sleep(1)
   print("Tabela após a deleção:")
   print("-"*60)
   showOrganizacao(sis)

   
def selectHoraTrabalhoOrg(sis):
   sql = """
         select nome from organizacao;
   """
   sis.execute_sql(sql)
   sis.showTable()
   
   
   print("-"*60)
   nomeOrg = input("Insira o nome da organização: ").upper()
   print("-"*60)
   print("Organização Selecionada: ", nomeOrg)
   print("-"*60)
   
   sql = f"""select v.hora_trabalho, count(o.cnpj) as qtde_funcionarios from voluntario v
	left join organizacao o on o.cnpj = v.organizacao and o.nome = '{nomeOrg}'
	group by v.hora_trabalho;
	"""
   
   sis.execute_sql(sql)
   sis.showTable()
   
   print("Deseja saber quais são os voluntários em cada horário?")
   ans = input("Digite S para sim e N para não: ").upper()
   if ans == 'S':
      horario = input("Digite o horário que deseja saber os voluntários (diurno ou noturno): ").upper()      
      
      sql = f"""select v.cpf, v.hora_trabalho from voluntario v
                  where v.organizacao = (select o.cnpj from organizacao o where o.nome = '{nomeOrg}') and v.hora_trabalho = '{horario}';"""
      sis.execute_sql(sql)
      sis.showTable()
   else: 
      recursion(sis)
      return
   
def showOrganizacaoQtdeVoluntario(sis):
   sql = """  
      select o.cnpj, o.nome, count(v.organizacao) as quantidade_voluntarios
      from organizacao o left join voluntario v on o.cnpj = v.organizacao 
      group by o.cnpj, o.nome 
      order by o.cnpj;"""
   sis.execute_sql(sql)
   sis.showTable()
   sis.closeConn()
   
def recursion(sis):
   time.sleep(2)
   print("-"*60)
   print("Qual operação deseja realizar agora?")
   print('-'*60)
   time.sleep(1)
   printHeader()
   selectOption(getOption(), sis)

def selectQtdeOrganizadoresOrg(sis):
   sql = """
   select o.cnpj, o.nome, count(c.setor) as quantidade_organizador
   from organizacao o left join voluntario v on o.cnpj = v.organizacao 
   left join organizador c on v.cpf= c.cpf
   group by o.cnpj,o.nome   
   order by o.cnpj;
   """
   sis.execute_sql(sql)
   sis.showTable()
   
def selectQtdeCozinheirosOrg(sis):
   sql = """
      	select o.cnpj, o.nome, count(c.posicao_cozinha) as qtde_cozinheiros
    from organizacao o left join voluntario v on o.cnpj = v.organizacao 
    left join cozinheiro c on v.cpf= c.cpf
    group by o.cnpj,o.nome   
    order by o.cnpj;
   """
   sis.execute_sql(sql)
   sis.showTable()
   
#-------------------------------------------------------------------------------   
def selectOption(opcao, sis):
   if opcao == 0:
      print("Tchau! =)\n")
      print("Fazendo logout do sistema...")
      time.sleep(1)
      print("-"*60)
      print("Logout do Sistema Concluido!")
      print("-"*60)
      
   #  Listar Organizações:
   elif opcao == 1:
      print("Listando Organizações...")
      print("-"*60)
      showOrganizacao(sis)
      recursion(sis)
      
   #  Inserção de Organização:
   elif opcao == 2:
      insertOrganizacao(sis)
      recursion(sis)
   
   #  Atualização de Organização: (commit após atualização.)
   elif opcao == 3:
      updateOrganizacao(sis)
      recursion(sis)

   # #Delete de Organização: (commit após o delete.)
   elif opcao == 4:
      deleteOrganizacao(sis)
      recursion(sis)

   # Insert de Voluntário:
   elif opcao ==5:
      insertVoluntario(sis)
      recursion(sis)
      
      
     
   # Buscar Organização e Qtde de Voluntarios
   elif opcao == 6:
      showOrganizacaoQtdeVoluntario(sis)
      recursion(sis)
      
      
   # Buscar Organizacao, Horário de Trabalho e Qtde de Voluntarios
   elif opcao == 7:
      selectHoraTrabalhoOrg(sis)
      recursion(sis)
      
   # Quantidade de Cozinheiros por Organização
   elif opcao == 8:
      selectQtdeCozinheirosOrg(sis)
      recursion(sis)
      
   #Quantidade de Organizadores por Organização   
   elif opcao == 9:
      selectQtdeOrganizadoresOrg(sis)
      recursion(sis)