#const y_max=5.
#const x_max=5.

rangoX(x_max).
rangoY(y_max).

fila(1..y_max).
columna(1..x_max).

color(verde, 1, 2).
color(verde, 1, 4).
color(azul, 4, 2).
color(azul, 2, 4).


colores(C) :- color(C, X, Y).

% parto de la posicion menor entre mis 2 opciones
%celdas_inicio(C, X1, Y1) :- Y1 < Y2, Y1!=Y2, color(C, X1, Y1), color(C, X2, Y2).
%celdas_inicio(C, X1, Y1) :- X1 < X2, X1!=X2, color(C, X1, Y1),color(C, X2, Y2).

%:- celdas_inicio(C, X1, Y1), celdas_inicio(C, X2, Y2), X1=X2, Y1=Y2.

1{celdas_inicio(C, X1, Y1)}1 :- color(C, X1, Y1), color(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).%, X1 != X2, Y1 != Y2, X1<X2.
%1{celdas_inicio(C, X1, Y1)}1 :- colores(C), color(C, X1, Y1), color(C, X2, Y2), X1  = X2, Y1 != Y2, Y1<Y2.
%1{celdas_inicio(C, X1, Y1)}1 :- colores(C), color(C, X1, Y1), color(C, X2, Y2), Y1  = Y2, X1 != X2, X1<X2.

%celdas_inicio(C, X1, Y1) :- X1 < X2, X1+Y1 = X2+Y2, color(C, X1, Y1), color(C, X2, Y2), X1!=X2, Y1!=Y2, X1!=Y2, X2!=Y1, fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).
%celdas_inicio(C, X1, Y1) :- X1 < X2, X1+Y1 = X2+Y2, color(C, X1, Y1), color(C, X2, Y2), X1!=X2, Y1=Y2, X1!=Y2, fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).
%celdas_inicio(C, X1, Y1) :- X1 < X2, X1+Y1 = X2+Y2, color(C, X1, Y1), color(C, X2, Y2), X1=X2, Y1!=Y2, X1!=Y2, fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).

%celdas_inicio(C, X1, Y1) :- X1+Y1 < X2+Y2, color(C, X1, Y1), X1!=X2, color(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).
%celdas_inicio(C, X1, Y1) :- X1+Y1 < X2+Y2, color(C, X1, Y1), Y1!=Y2, color(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).


ocupadas(X, Y) :- celdas_inicio(C, X, Y), colores(C).

% termino en la posicion mayor entre mis 2 opciones
celdas_termino(C, X1, Y1) :- color(C, X1, Y1), color(C, X2, Y2), celdas_inicio(C, X2, Y2), X1!=X2, Y1!=Y2, fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).

% hay solo un camino que sale desde el inicio 
1{camino(C, X1, Y1, X3, Y3): fila(Y3), columna(X3)}1 :-  celdas_inicio(C, X1, Y1).


% el camino va de una celda a otra distinta 
:- camino(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2),  colores(C), X1=X2, Y1=Y2.

% Ningun camino llega a una celda inicial
:- camino(C1, X1, Y1, X2, Y2), celdas_inicio(C, X2, Y2), fila(Y1), fila(Y2), colores(C1), colores(C2).

% no pueden salir 2 caminos de una misma celda
:- camino(C1, X3, Y3, X1, Y1), camino(C2, X3, Y3, X2, Y2), X1!=X2, Y1!=Y2, colores(C1), colores(C2).

% no puedo avanzar fuera del tablero
:-  camino(C, X1, Y1, X2, Y2), not columna(X2).
:-  camino(C, X1, Y1, X2, Y2), not fila(Y2).


% no pueden llegar 2 caminos de una misma celda
lleguen_2_caminos_a_una_celda(X3, Y3) :- camino(C1, X1, Y1, X3, Y3), camino(C2, X2, Y2, X3, Y3), X1!=X2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(X3, Y3) :- camino(C1, X1, Y1, X3, Y3), camino(C2, X2, Y2, X3, Y3), Y1!=Y2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).

:- lleguen_2_caminos_a_una_celda(X3, Y3), columna(X3), fila(Y3).

% opciones de movimiento: arriba, abajo, izquierda, derecha
{opcion_movimiento(C, X1, Y1, X2, Y2) : X1 - X2 <= 1, X1 - X2 >= -1,  Y1 - Y2 <= 1, Y1 - Y2 >= -1} :- camino(C, X3, Y3, X1, Y1),  fila(Y2),  columna(X2).
{opcion_movimiento(C, X1, Y1, X2, Y2) : X1 - X2 <= 1, X1 - X2 >= -1,  Y1 - Y2 <= 1, Y1 - Y2 >= -1} :- celdas_inicio(C, X1, Y1),  fila(Y2),  columna(X2).

% opcion de movimiento a una celda distinta
:- opcion_movimiento(C, X1, Y1, X2, Y2), X1=X2, Y1=Y2.

% no mover en diagonal
:- opcion_movimiento(C, X1, Y1, X2, Y2), X1!=X2, Y1!=Y2.

% no puede haber un camino invaldio 
:- camino(C, X1, Y1, X2, Y2), not opcion_movimiento(C, X1, Y1, X2, Y2).


% solo un camino llega al final
%:- camino(C, X1, Y1, X2, Y2), camino(C, X3, Y3, X2, Y2), celdas_termino(C, X2, Y2), not misma_celda(C, X1, Y1, X3, Y3), fila(Y1), fila(Y2), columna(X1), columna(X2),  colores(C), fila(Y3), columna(X3).
{camino(C, X3, Y3, X2, Y2): fila(Y3), columna(X3)}1 :- celdas_termino(C, X2, Y2).

% para todo camino que no esta en el final, sale un unico camino
1{camino(C, X2, Y2, X3, Y3): fila(Y3), columna(X3)} :-  camino(C, X1, Y1, X2, Y2), not celdas_termino(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2),  colores(C).

% un camino pasa por cada celda 
%:- not camino(C, X1, Y1, X2, Y2), not celdas_inicio(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2),  colores(C).
1{camino(C, X1, Y1, X2, Y2) : colores(C), fila(Y1), columna(X1)}1 :-  not ocupadas(X2, Y2), columna(X2), fila(Y2).


%opcion_movimiento(C, X1, Y1, X2, Y2) :- not no_opcion_movimiento(C, X1, Y1, X2, Y2), colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2).

% no puede haber una 


%toda opcion de movimiento parte desde un nodo donde llego un camino 
%opcion_movimiento(C, X1, Y1, X2, Y2) :- camino(C, X3, Y3, X1, Y1), colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2), fila(Y3), columna(X3).

% Todo movimiento debe mantener la fila o la columna, no pueden cambiar ambas
:- opcion_movimiento(C, X1, Y1, X2, Y2), X1!=X2, Y1!=Y2, colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2).

% todo camino sigue una opcion de movimiento valida, NO puede ser invalida y ser un camino
:- camino(C, X1, Y1, X2, Y2), not opcion_movimiento(C, X1, Y1, X2, Y2) , colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2).

%#show color/3.
%#show colores/1.
%#show camino/5.
%#show opcion_movimiento/5.

%#show rangoX/1.
%#show rangoY/1.
#show celdas_inicio/3.
#show celdas_termino/3.
