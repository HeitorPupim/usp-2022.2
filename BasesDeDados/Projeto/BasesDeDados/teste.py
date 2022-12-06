def validateString(string):
   lista = [";", "'", "--", "/*", "xp_"]
   if any(x in string for x in lista):
      print("Erro: String inválida!!!! Tente novamente")


inp_string = validateString(input("Digite uma string: "))