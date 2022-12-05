import host_connection as hc  
import interface as i

sis = hc.Sistema()

sis.connect()

i.printHello()
i.printHeader()
   
   
i.selectOption(i.getOption(), sis)   

