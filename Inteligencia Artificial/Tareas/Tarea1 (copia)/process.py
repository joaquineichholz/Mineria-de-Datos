import sys
import numpy as np

lines = sys.stdin.readlines()

init=0
while "color(" not in lines[init]:
    init+=1

atoms = lines[init].split(" ")

obstacles=[]

rangoX = 0
rangoY = 0
X = []
Y = []
X_ = []
Y_ = []
values = []
values_ = []

Y_inicio = []
X_inicio = []
values_inicio = []

Y_termino = []
X_termino = []
values_termino = []

aux = []

for l in atoms:
    print(l)

i = 0
for line in atoms:
    if line[0:6] == "rangoX":
        line=line.replace("rangoX","")
        line=line.replace("(","")
        line=line.replace(")","")
        rangoX = int(line)
        continue

    if line[0:6] == "rangoY":
        line=line.replace("rangoY","")
        line=line.replace("(","")
        line=line.replace(")","")
        rangoY = int(line)
        continue


    elif line[0:5] == "color":

        line=line.replace("color","")
        line=line.replace("(","")
        line=line.replace(")","")
        line = line.split(",")

        Y.append(int(line[2]))
        X.append(int(line[1]))
        values.append(line[0])

        Y_.append(int(line[2]))
        X_.append(int(line[1]))
        values_.append("c_" + line[0])


    if line[0:len("celdas_inicio")] == "celdas_inicio":
    
        line=line.replace("celdas_inicio","")
        line=line.replace("(","")
        line=line.replace(")","")
        line = line.split(",")

        Y_inicio.append(int(line[2]))
        X_inicio.append(int(line[1]))
        values_inicio.append("i_"+str(line[0]))
    
    if line[0:len("celdas_termino")] == "celdas_termino":
    
        line=line.replace("celdas_termino","")
        line=line.replace("(","")
        line=line.replace(")","")
        line = line.split(",")

        Y_termino.append(int(line[2]))
        X_termino.append(int(line[1]))
        values_termino.append("t_"+str(line[0]))

    elif line[0:6] == "camino":
        
        line=line.replace("camino","")
        line=line.replace("(","")
        line=line.replace(")","")
        line = line.split(",")

        Y.append(int(line[4]))
        X.append(int(line[3]))
        values.append(f"->"+ str(line[0]))

        aux.append(( str(line[0]), f"({line[2]}, {line[1]}) -> ({line[4]}, {line[3]}) "))


aux = sorted(aux, key=lambda x: x[0])

for x in range(len(values_inicio)):
    print(f"inicio, {values_inicio[x]}({X_inicio[x]}, {Y_inicio[x]})")
print()
for x in range(len(values_termino)):
    print(f"termino, {values_termino[x]}({X_termino[x]}, {Y_termino[x]})")

print()

for x in aux:
    print(f"{x[0]}: {x[1]}")
    

matriz = [None] * rangoY
for x in range(rangoY):
    matriz[x] = ["--"] * rangoX

for i in range(len(values)):
    matriz[Y[i] - 1][X[i] - 1] = values[i]

for i in range(len(values_)):
    matriz[Y_[i] - 1][X_[i] - 1] = values_[i]

for i in range(len(values_inicio)):
    matriz[Y_inicio[i] - 1][X_inicio[i] - 1] = values_inicio[i]

for i in range(len(values_termino)):
    matriz[Y_termino[i] - 1][X_termino[i] - 1] = values_termino[i]
string = "   "
for row in range(rangoY):
    string += "{:^12}".format(str(row + 1)) 

string += "\n"

for row in range(rangoY):
    string += f"-----------"


string += "------\n"

#matriz = np.matrix(matriz)
#matriz = matriz.T
i = rangoX
for y in matriz:
    string += str(i) + " |"
    i -= 1

    for x in y:
       string += "{:<12}".format(str(x)) 
    
    string += "\n"

print(string)

"""while True:
    if i / rangoX == i // rangoX:
        if i != 0 :
            string += "\n"
        string += str(i // rangoX) + " |"

    string += str(values[i]) + " "
    
    i += 1

    if i >= len(values):
        break"""

    



'''for col in range(len(rangoX)):
    try:
        string += str(values[i]) + " "
    except:
        print(f"{i} fuera de rango")
    i += 1
string += "\n"'''

