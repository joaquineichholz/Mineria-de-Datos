#const y_max=15.
#const x_max=15.

rangoX(x_max).
rangoY(y_max).

columna(1..y_max).
fila(1..x_max).

color(blanco,1,4).
color(cafe_claro,1,9).
color(rosa2,1,14).
color(morado,1,15).
color(azul,2,7).
color(verde_oscuro,2,8).
color(rosa2,2,9).
color(cafe_claro,2,10).
color(naranjo,3,8).
color(celeste,3,14).
color(rojo,3,15).
color(azul,4,3).
color(verde_oscuro,5,2).
color(burdeo,5,7).
color(fucsia,5,15).
color(petroleo,6,4).
color(burdeo,6,5).
color(azul_oscuro,7,12).
color(fucsia,7,15).
color(amarillo,8,8).
color(morado,8,9).
color(amarillo,9,7).
color(verde_claro,9,13).
color(celeste,10,5).
color(naranjo,10,13).
color(azul_oscuro,11,13).
color(gris,12,8).
color(verde_claro,12,14).
color(rojo,12,15).
color(gris,13,3).
color(petroleo,14,14).
color(blanco,15,10).

colores(C) :- color(C, Y, X).


%:- celdas_inicio(C, Y1, X1), celdas_inicio(C, Y2, X2), X1=X2, Y1=Y2.

1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 != X2, Y1 != Y2, X1<X2.
1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 = X2, Y1 != Y2, Y1<Y2.
1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 != X2, Y1 = Y2, X1<X2.


% termino en la posicion mayor entre mis 2 opciones
celdas_termino(C, Y1, X1) :- color(C, Y1, X1), not celdas_inicio(C, Y1, X1).


% solo un camino llega al final
1{camino(C1, Y1, X1, Y3, X3): columna(Y1), fila(X1)}1 :- celdas_termino(C1, Y3, X3), colores(C1).


% no pueden llegar 2 caminos a una misma celda
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), X1!=X2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), X1!=X2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), Y1!=Y2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), Y1!=Y2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).


:- lleguen_2_caminos_a_una_celda(Y3, X3), fila(X3), columna(Y3).


% opciones de movimiento: arriba, abajo, izquierda, derecha
{opcion_movimiento(C, Y1, X1, Y2, X2) : X1 - X2 <= 1, X1 - X2 >= -1,  Y1 - Y2 <= 1, Y1 - Y2 >= -1} :- camino(C, Y3, X3, Y1, X1),  columna(Y2),  fila(X2).
{opcion_movimiento(C, Y1, X1, Y2, X2) : X1 - X2 <= 1, X1 - X2 >= -1,  Y1 - Y2 <= 1, Y1 - Y2 >= -1} :- celdas_inicio(C, Y1, X1),  columna(Y2),  fila(X2).

% opcion de movimiento a una celda distinta
:- opcion_movimiento(C, Y1, X1, Y2, X2), X1=X2, Y1=Y2.

% no mover en diagonal
:- opcion_movimiento(C, Y1, X1, Y2, X2), X1!=X2, Y1!=Y2.

% no puede haber una opcion de movimiento si no hay un camino que haya llegado a esa celda
:- opcion_movimiento(C, Y1, X1, Y2, X2), not camino(C, Y1, X1, Y2, X2).

% no puede haber un camino invaldio 
:- camino(C, Y1, X1, Y2, X2), not opcion_movimiento(C, Y1, X1, Y2, X2).

%no puede salir un camino de un color distinto al de la celda
:- camino(C1, Y1, X1, Y2, X2), color(C2, Y1, X1), C1!=C2, columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).
:- camino(C1, Y1, X1, Y2, X2), color(C2, Y2, X2), C1!=C2, columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).

% un camino pasa por cada celda 
%:- not 20{camino(C, Y1, X1, Y2, X2) : colores(C), columna(Y1), fila(X1), columna(Y2), fila(X2)}.% :-  not celdas_termino(C1, Y3, X3), fila(X3), columna(Y3), colores(C1).
%1{camino(C, Y1, X1, Y2, X2): columna(Y1), fila(X1), colores(C), colores(C1)}1 :- columna(Y2), fila(X2).
%1{camino(C, Y1, X1, Y2, X2); celdas_inicio(C1, Y2, X2) : colores(C), colores(C1), columna(Y1), fila(X1)}1 :- columna(Y2), fila(X2).

%1{con_camino(X, Y)}1 :- columna(Y), fila(X), not celdas_inicio(C, X, Y), colores(C).
%:- con_camino(X, Y), celdas_inicio(C, X, Y), colores(C), columna(Y), fila(X).

%:- not camino(C1, Y1, X1, Y2, X2), not color(C2, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).

% Ningun camino llega a una celda inicial
:- camino(C1, Y1, X1, Y2, X2), celdas_inicio(C2, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).


% por toda celda pasa un camino 
pasa_camino(X2, Y2) :- camino(C, X1, Y1, X2, Y2), colores(C), columna(X1), columna(X2), fila(Y1), fila(Y2). 
pasa_camino(X1, Y1) :- camino(C, X1, Y1, X2, Y2), colores(C), columna(X1), columna(X2), fila(Y1), fila(Y2). 

:- columna(X), fila(Y), not pasa_camino(X, Y).


#show color/3.
#show camino/5.