import host_connection as hc  
import interface as i

sis = hc.Sistema()

#abrindo conexão com o banco de dados
sis.connect()

#printando tabelas e rodando o programa.
i.printHello()
i.printHeader()
i.selectOption(i.getOption(), sis)   


#fechando conexão com o banco de dados.
sis.closeConn()