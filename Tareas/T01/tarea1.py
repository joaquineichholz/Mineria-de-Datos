import numpy as np
import pandas as pd
from datetime import datetime
from itertools import tee
from functools import reduce


def join_conjunto_listas(conjuntos, muertes):
    nuevo_conjunto = []
    siguiente_conjunto = 1
    tiempo = datetime.now()
    for A in conjuntos[:-1]:
        for B in conjuntos[siguiente_conjunto:]:
            if A[:-1] == B[:-1]:
                if A[-1] < B[-1]:
                    C = A + [B[-1]]
                else:
                    C = B + [A[-1]]

                # muere = False
                '''for tupla in muertes:
                    muere = True

                    for dato in tupla:
                        if dato not in tupla:
                            muere = False
                            break
                    if muere:
                        break

                if not muere:
                    nuevo_conjunto.append(C)'''

                if not len(list(filter(lambda muerte: all(dato in C for dato in muerte), muertes))):
                    nuevo_conjunto.append(C)

        siguiente_conjunto += 1

    # print('\nMe demoré {} seg en el join'.format((datetime.now() - tiempo).total_seconds()))

    return nuevo_conjunto


def conjuntos_sobre_umbral_listas(tuplas, conjuntos, frec_min):
    '''
    tuplas: tuplas de la base de datos (lista de listas)
    conjuntos: conjuntos a revisar (lista de listas)
    frec_min: int, umbral minimo para seguir en la proxima iteración
    '''
    tiempo1 = datetime.now()

    n_tuplas = len(tuplas)
    # tuplas, t2 = tee(tuplas)

    # n_tuplas = reduce(lambda x, y: x + 1, t2, 0)
    # print(n_tuplas)
    sobrevivientes = []
    muertes = []

    for conjunto in conjuntos:
        contador = 0
        # print()
        # print('conjunto:', conjunto)

        # tuplas, t2 = tee(tuplas)
        for tupla in tuplas:
            # print('tupla:', tupla)
            for dato in conjunto:
                if dato not in tupla:
                    contador -= 1
                    break
            contador += 1
            # print('contador:', contador)
            # if all(dato in tupla for dato in conjunto):
            #    contador += 1
            # print(round(contador / n_tuplas, 2), conjunto)

            if contador >= frec_min:  # contador / n_tuplas >= frec_min:
                sobrevivientes.append(conjunto)
                # print('contador:', contador)
                break  ##############
            # print(round(contador / n_tuplas, 2), conjunto)


        else:
            muertes.append(conjunto)

    # print('\nMe demoré {} seg en el conjunto sobre umbral'.format((datetime.now() - tiempo1).total_seconds()))
    return sobrevivientes, muertes


def fit(frec_min, datos='spotify.npy'):
    data = np.load(datos)
    listas_datos = [x for x in dict(data.item()).values()][:10]
    frec_min = frec_min * len(listas_datos)

    orden = list(set([x for songs in listas_datos for x in songs]))
    enumeracion_orden = dict(enumerate(orden))  # {0: cancion1, 1: cancion2}...
    dict_orden = {x[1]: x[0] for x in enumeracion_orden.items()}  # {cancion1: 0, cancion2: 1... }

    tuplas = list(map(lambda dato: sorted(list(dict_orden[x] for x in dato)), listas_datos))
    # tuplas = (map(lambda dato: sorted(list(dict_orden[x] for x in dato)), listas_datos))
    # tuplas esta ordenada en orden ascendente de menor a mayor

    conjuntos = [[x] for x in dict_orden.values()]
    # conjuntos = ([x] for x in dict_orden.values())

    '''####################

    tuplas = [[1, 2, 5], [2, 4], [2, 3], [1, 2, 4], [1, 3], [2, 3], [1, 3], [1, 2, 3, 5], [1, 2, 3]]

    conjuntos = [[1], [2], [3], [4], [5]]
    print(frec_min)

    frec_min = frec_min * len(tuplas)
    print(frec_min)



    ####################'''

    eliminados = []
    retorno = []

    k = 0
    while True:
        k += 1
        # print(' --- iteracion {} ---'.format(k))
        # conjuntos, c1 = tee(conjuntos)
        listas, muerte = (conjuntos_sobre_umbral_listas(tuplas, conjuntos, frec_min))
        conjuntos = join_conjunto_listas(listas, muerte)


        if not listas:
            print('--- --- --- ')
            return retorno

        else:
            # a = [[enumeracion_orden[x]] for dato in listas for x in dato]
            # a = [[x] for dato in listas for x in dato]
            '''aux = []
            for conjunto in listas:
                l = []
                for dato in conjunto:
                    l.append(enumeracion_orden[dato])
                aux.append(l)'''

            retorno.extend(listas)


if __name__ == '__main__':
    tiempo = datetime.now()
    a = fit(0.06)
    print((datetime.now() - tiempo).total_seconds())
    for x in a:
        print(x)
