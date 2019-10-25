


% definimos arcos
:- camino(C1, Y1, X1, Y2, X2), fila(Y1), fila(X1), columna()


% toda casilla debe ser ocupada por un camino


pintada(X, Y) :- camino(C, X1, Y1, X, Y), colores(C), fila(X1), fila(X), columna(Y1), columna(Y). 
pintada(X1, Y1) :- camino(C, X1, Y1, X, Y), colores(C), fila(X1), fila(X), columna(Y1), columna(Y). 

:- fila(X), columna(Y), not pintada(X, Y). 



%:- casillas_entrantes(X, Y), not camino(C, X1, Y1, X, Y), fila(X), fila(X1), columna(Y), columna(Y1), colores(C), X!=X1, Y!=Y1.



% dos caminos no pueden llegar al mismo lugar

    %:- camino(C1, X1, Y1, X, Y), camino(C2, X2, Y2, X, Y), X1 != X2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).
    %:- camino(C1, X1, Y1, X, Y), camino(C2, X2, Y2, X, Y), Y1 != Y2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).
    %:- camino(C1, X1, Y1, X, Y), camino(C2, X2, Y2, X, Y), X1 != X2, Y1!=Y2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).

lleguen_2_caminos_a_una_celda(X3, Y3) :- camino(C1, X1, Y1, X3, Y3), camino(C2, X2, Y2, X3, Y3), X1!=X2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(X3, Y3) :- camino(C1, X1, Y1, X3, Y3), camino(C2, X2, Y2, X3, Y3), Y1!=Y2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).

:- lleguen_2_caminos_a_una_celda(X3, Y3), columna(X3), fila(Y3).

% dos caminos no pueden partir desde el mismo lugar

:- camino(C1, X, Y, X1, Y1), camino(C2, X, Y, X2, Y2), X1 != X2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).
:- camino(C1, X, Y, X1, Y1), camino(C2, X, Y, X2, Y2), Y1 != Y2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).
:- camino(C1, X, Y, X1, Y1), camino(C2, X, Y, X2, Y2), X1 != X2, Y1!=Y2, fila(X1), fila(X2), fila(X), columna(Y1), columna(Y2), columna(Y), colores(C1), colores(C2).

% camino de un color no puede pisar camino de otro color

:-camino(C1, X1, Y1, X, Y),camino(C2, X, Y, X2, Y2), fila(X1),fila(X),fila(X2),columna(Y1),columna(Y),columna(Y2), colores(C), C1 != C2.


% Restringir el objetivo

objetivo(C) :- camino(C, X1, Y1, X2, Y2), final(C, X2, Y2), colores(C), fila(X1), columna(Y1), fila(X2), columna(Y2). 

:- not objetivo(C), colores(C).
