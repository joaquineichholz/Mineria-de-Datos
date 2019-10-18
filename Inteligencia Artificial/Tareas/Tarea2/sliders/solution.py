#   Look for #IMPLEMENT tags in this file. These tags indicate what has
#   to be implemented to complete the homework.

#   You may add only standard python imports---i.e.
#   You may not remove any imports.
#   You may not import or otherwise source any of your own files
#   Runs this file requiere numpy library and python 3.6 or higher

import os #for time functions
import math
from search import * #for search engines
from sliders import *
from problems import *
from datetime import datetime


#SLIDERS HEURISTICS
def sliders_h_zero(state):
    return 0

def sliders_h_basic(state):



    sum_in_width = 0
    sum_in_height = 0
    for width in range(state.tiles.shape[0]):
        correlative = np.arange(np.min(state.tiles[width]), np.min(state.tiles[width])+state.tiles.shape[1], 1)
        if np.array_equal(state.tiles[width], correlative) is False:
            sum_in_width += 1
    for height in range(state.tiles.shape[1]):
        correlative = np.arange(np.min(state.tiles[:,height]), state.tiles.shape[1]+np.min(state.tiles[:,height])+1, state.tiles.shape[1] )
        if np.array_equal(state.tiles[:,height], correlative) is False :
            sum_in_height += 1

    return min(sum_in_width,sum_in_height)  


def sliders_h_alternate(state):
#IMPLEMENT
#----------------------------------------------
    '''a better heuristic'''
    '''INPUT: a sliders state'''
    '''OUTPUT: a numeric value that serves as an estimate of the distance of the state to the goal.'''
    #Write a heuristic function that improves upon h_basic to estimate distance between the current state and the goal.
    #Your function should return a numeric value for the estimate of the distance to the goal.


    n_col = state.tiles.shape[1]
    n_row = state.tiles.shape[0]

    h_x = 0
    h_y = 0

    # print(state.print_state())

    posiciones_x = dict()
    posiciones_y = dict()
    solucion = []
    i = 0
    for row in range(n_row):
        aux = []
        for col in range(n_col):
            posiciones_x[i] = col
            posiciones_y[i] = row
            aux.append(i)
            i += 1
        solucion.append(aux)

    '''
    print("")
    for x in solucion:
        print(x)
    print()
    print("posicion x", posiciones_x)
    print("posicion y", posiciones_y)
    print()
    '''

    for row in range(state.tiles.shape[0]):
        s = ''
        aux_h_x = 0
        aux_h_y = 0
        for col in range(state.tiles.shape[1]):
            ficha = state.tiles[row][col]

            s += ' ' + str(ficha)

            aux_h_x = abs(col - posiciones_x[ficha])
            # si el camino es mayor a la mitad me conviene atravesar la pared
            if aux_h_x > n_col / 2:
                aux_h_x = n_col - aux_h_x

            aux_h_y = abs(row - posiciones_y[ficha])
            # si el camino es mayor a la mitad me conviene atravesar la pared
            if aux_h_y > n_row / 2:
                aux_h_y = n_row - aux_h_y

            h_x += aux_h_x
            h_y += aux_h_y

    '''
        print(s)
    
    print()
    print("h_x", h_x)
    print("h_y", h_y)
    '''
    return h_y / n_row + h_x / n_col


def fval_function(sN, weight):
    """
    Provide a custom formula for f-value computation for Weighted A star.
    Returns the fval of the state contained in the sNode.

    @param sNode sN: A search node (containing a SlidersState)
    @param float weight: Weight given by Anytime Weighted A star
    @rtype: float
    """
  
    #Many searches will explore nodes (or states) that are ordered by their f-value.
    #For UCS, the fvalue is the same as the gval of the state. For best-first search, the fvalue is the hval of the state.
    #You can use this function to create an alternate f-value for states; this must be a function of the state and the weight.
    #The function must return a numeric f-value.
    #The value will determine your state's position on the Frontier list during a 'custom' search.
    #You must initialize your search engine object as a 'custom' search engine if you supply a custom fval function.
    #print(sN.gval, sN.hval, sN.gval + weight*sN.hval )
    return sN.gval + weight*sN.hval

def weighted_astar(initial_state, heur_fn, weight=1., timebound = 10):
    '''Provides an implementation of weighted a-star'''
    '''INPUT: a sliders state that represents the start state and a timebound (number of seconds)'''
    '''OUTPUT: A goal state (if a goal is found), else False'''
    '''implementation of weighted astar algorithm'''
    t = datetime.now()
    wa_se = SearchEngine('custom', 'full')
    wa_se.trace_on(0)
    wa_se.init_search(initial_state, sliders_goal_state, heur_fn, (lambda sN: fval_function(sN, weight)))
    result = wa_se.search(timebound=timebound)

    if result:
        print(f"\tgvaul = {result.gval}, t = {(datetime.now() - t).total_seconds()}")
        return result
    else :
        print("\tsolucion no encontrada")
        return False


def anytime_weighted_astar(initial_state, heur_fn, weight=1., timebound = 10):
    #IMPLEMENT
    #----------------------------------------------
    '''Provides an implementation of anytime weighted a-star (AWA*), as described in the Homework'''
    '''INPUT: a sliders state that represents the start state and a timebound (number of seconds)'''
    '''OUTPUT: A goal state (if a goal is found), else False'''
    '''implementation of weighted astar algorithm'''

    t = datetime.now()
    best = False
    costo_solucion=[999999, 999999, 999999]
    inicio = os.times()[0]
    i = 0
    best = False
    delta = 0.1

    search = SearchEngine('custom', 'full')
    search.trace_on(0)
    search.init_search(initial_state, sliders_goal_state, heur_fn, (lambda sN: fval_function(sN, weight)))
    '''
    #result = search.search(timebound=timebound, costbound=costo_solucion)

    #print(f"\n0.- \n gvaul = {result.gval}\n")

    #result.print_state()

    #nodo_inicial = result.parent
    #open_actual = search.open.open

    #if result:
     #   costo_solucion[2] = result.gval - delta
      #  best = result

    #else:
     #   return False

    #open_actual = Open(search.strategy)
    #open_actual.open = search.open.open
    '''

    i = 0
    while search.open.open and timebound > 0: # while queden elementos
        result = search.search(timebound=timebound, costbound=costo_solucion)

        if result:
            costo_solucion[2] = result.gval - delta
            best = result
            timebound = search.search_stop_time - os.times()[0]

        else:
            print("\tno más soluciones encontradas")
            break

        print(f"\t{i}.- \n gvaul = {best.gval}, t = {(datetime.now() - t).total_seconds()}")

        i+=1

    return best

def restarting_weighted_astar(initial_state, heur_fn, weight=1., phi=0.8, timebound = 10):
    #IMPLEMENT
    #-  ---------------------------------------------
    '''Provides an implementation of RWA*, as described in the homework'''
    '''INPUT: a sliders state that represents the start state, an heuristic function, an initial weight, a phi parameter and a timebound (number of seconds)'''
    '''OUTPUT: A goal state (if a goal is found), else False'''
    '''implementation of weighted astar algorithm'''
    delta = 0.1

    costo_solucion=[999999, 999999, 999999]
    i = 0
    best = False
    t = datetime.now()

    while weight >= 1 and timebound > 0:
        search = SearchEngine('custom', 'full')
        search.trace_on(0)
        search.init_search(initial_state, sliders_goal_state, heur_fn, (lambda sN: fval_function(sN, weight)))
        result = search.search(timebound=timebound, costbound=costo_solucion)

        if result:
            costo_solucion[2] = result.gval - delta
            timebound = search.search_stop_time - os.times()[0]
            best = result

        else:
            print("\tno más soluciones encontradas")
            break

        print(f"\tgvaul = {result.gval}, t = {(datetime.now() - t).total_seconds()}")

        #if result: result.print_path()

        if weight == 1: # si ya realice el algoritmo con w=1 paro, ya que estoy en el optimo
            break

        weight = weight * phi
        i+=1

    return best





if __name__ == "__main__":

    #sample runs 
    se = SearchEngine('astar', 'full')

    #If you want to trace the search, set trace_on.  Using Level 1 for illustration. Level 2 prints more detailed results.    
    #se.trace_on(0)
    #se.trace_on(1)

    se.trace_on(2)
    i=0
    for s0 in PROBLEMS:
        print(f"\nTablero {i}")
        i += 1
        """
        print("=========Demo 1. Astar with h_zero heuristic========")
        se.init_search(s0, sliders_goal_state, sliders_h_zero)
        final = se.search(timebound=20)
        if final: final.print_path()
        print("===================================================")
    
        print("=========Demo 2. Astar with h_basic heuristic========")
        se.init_search(s0, sliders_goal_state, sliders_h_basic)
        final = se.search(timebound=20)
        if final: final.print_path()
        print("===================================================")
        
        print("=========Demo 3. Weighted Astar with h_basic heuristic========")
        weight = 10
        final = weighted_astar(s0, heur_fn=sliders_h_basic, weight=weight, timebound=20)
        if final: final.print_path()
        print("===================================================")
        print()
        print("costo actual:",final.gval)
        """

        weight = 10

        print("\t========= Weighted Astar with sliders_h_alternate")
        final = weighted_astar(s0, heur_fn=sliders_h_alternate, weight=weight, timebound=20)
        #if final: final.print_path()

        print("\t========= Aanytime Weighted Astar with sliders_h_alternate ========")
        final = anytime_weighted_astar(s0, heur_fn=sliders_h_alternate, weight=weight, timebound = 20)
        #if final: final.print_path()

        print("\t========= Restarting Weighted Astar with sliders_h_alternate ========")
        final = restarting_weighted_astar(s0, heur_fn=sliders_h_alternate, weight=weight, phi=0.8, timebound = 20)
        #if final: final.print_path()






