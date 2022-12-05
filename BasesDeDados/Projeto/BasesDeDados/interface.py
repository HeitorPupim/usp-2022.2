import time


def printHello():
   print("-"*60 + "\n")
   print("Bem vindo!\n")
   time.sleep(1)   


def printHeader():
   print("Escolha uma das opções abaixo:")
   print("-"*60)
   print("1 - Inserir organização")
   print("2 - Atualizar organização")
   print("3 - Inserir Voluntário")
   print("4 - Listar Organizações")
   print("5 - Buscar Organização e a quantidade de voluntários")
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
   else:    print("Opção inválida!")
   print("Tabela após a atualização:")
   print("-"*60)
   sql = f"""select * from organizacao where cnpj = {cnpj};"""
   sis.execute_sql(sql)
   sis.showTable()
   sis.commit()   

def showOrganizacao(sis):
   sis.execute_sql("select * from organizacao order by cnpj asc;")
   sis.showTable()
   sis.commit()

#-------------------------------------------------------------------------------   
def selectOption(opcao, sis):
   if opcao == 0:print("Tchau! =)")
   
   #  Inserir organização:
   elif opcao == 1:
      insertOrganizacao(sis)
   
   #  Atualização de organização:
   elif opcao == 2:
      updateOrganizacao(sis)
   
   #Inserção de Voluntário:
   elif opcao == 3:
      insertVoluntario(sis)

   # Listar Organizações:
   elif opcao == 4:
      showOrganizacao(sis)

   #Listar Organizações e a quantide de pontos:
   elif opcao ==5:
      sql = """  
      select o.cnpj, o.nome, count(v.organizacao) as quantidade_voluntarios
      from organizacao o left join voluntario v on o.cnpj = v.organizacao 
      group by o.cnpj, o.nome 
      order by o.cnpj;"""
      sis.execute_sql(sql)
      sis.showTable()
      sis.closeConn()
