import psycopg2
from prettytable import PrettyTable


class Sistema():
   def __init__(self):
      self.conn = None
      self.cursor = None
      
   def connect(self):
      # Dados de conexão com o banco de dados
      (host, dbname, user, password) = ('localhost', 'postgres', 'postgres', 'postgres')

      # Cria a string de conexão
      conn_string = "host='{}' dbname='{}' user='{}' password='{}'".format(host, dbname, user, password)

      # Conecta ao banco de dados
      self.conn = psycopg2.connect(conn_string)

      # Cria um cursor
      self.cursor = self.conn.cursor()
   
   def execute_sql(self, sql):
   
      # Executa a instrução SQL
      self.cursor.execute(sql)
      #salva as alterações no banco de dados:

   def commit(self):
      self.conn.commit()
      self.conn.close()

   def showTable(self):
      # obtem resultados:
      resultados = self.cursor.fetchall()
      # cria tabela:
      tabela = PrettyTable()
      #  obtem nome das colunas
      colunas = [desc[0] for desc in self.cursor.description]
      # Adiciona as colunas à tabela
      tabela.field_names = colunas
      # Adiciona os resultados à tabela
      for linha in resultados:
         tabela.add_row(linha)
      # Mostra a tabela no terminal
      print(tabela)

   def closeConn(self):
      self.conn.close()