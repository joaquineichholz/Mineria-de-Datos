#const y_max=5.
#const x_max=5.

rangoX(x_max).
rangoY(y_max).

columna(1..y_max).
fila(1..x_max).

color(verde, 3, 1).
color(verde, 4, 1).
color(azul, 5, 1).
color(azul, 5, 3).
color(blanco, 5, 4).
color(blanco, 4, 5).
color(amarillo, 3, 3).
color(amarillo, 3, 4).
color(morado, 3, 5).
color(morado, 2, 4).

colores(C) :- color(C, Y, X).


1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 != X2, X1<X2.
1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 = X2, Y1<Y2.

% termino en la posicion mayor entre mis 2 opciones
%celdas_termino(C, Y1, X1) :- color(C, Y1, X1), not celdas_inicio(C, Y1, X1).


% si o si solo un camino llega al final
1{camino(C1, Y1, X1, Y3, X3): columna(Y1), fila(X1)}1 :- celdas_termino(C1, Y3, X3).


% si o si hay solo un camino que sale desde el inicio 
1{camino(C2, Y1, X1, Y1 + 1, X1);
 camino(C2, Y1, X1, Y1 - 1, X1); 
 camino(C2, Y1, X1, Y1, X1 + 1); 
 camino(C2, Y1, X1, Y1, X1 - 1)}1 :-  celdas_inicio(C2, Y1, X1), colores(C2).

% para todo camino que NO esta en el final, sale un unico camino
1{camino(C, Y2, X2, Y3, X3): columna(Y3), fila(X3)}1 :-  camino(C, Y1, X1, Y2, X2), not celdas_termino(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2),  colores(C).

% todo camino viene desde una celda adyacente 
%1{camino(C2, Y1 + 1, X1, Y1, X1);
% camino(C2, Y1 - 1, X1, Y1, X1); 
% camino(C2, Y1, X1 + 1, Y1, X1); 
% camino(C2, Y1, X1 - 1, Y1, X1)}1 :-  camino(C2, Y1, X1, Y2, X2), columna(X2), columna(Y2), colores(C2).


% definimos arcos
1{camino(C,X,Y,X+1,Y);camino(C,X,Y,X-1,Y);camino(C,X,Y,X,Y+1);camino(C,X,Y,X,Y-1)}1 :- inicio(C, X, Y), fila(X), columna(Y).
1{camino(C,X2,Y2,X2+1,Y2);camino(C,X2,Y2,X2-1,Y2);camino(C,X2,Y2,X2,Y2+1);camino(C,X2,Y2,X2,Y2-1)}1 :- camino(C,X1,Y1,X2,Y2), fila(X1), columna(Y1), fila(X2), columna(Y2), colores(C), not final(C, X2, Y2).   

% rango
:- camino(C, X1, Y1, X2, Y2), not fila(X1). 
:- camino(C, X1, Y1, X2, Y2), not fila(X2). 
:- camino(C, X1, Y1, X2, Y2), not columna(Y1). 
:- camino(C, X1, Y1, X2, Y2), not columna(Y2). 

%:- camino(Y1, X1, Y2, X2), Y2>y_max.
%:- camino(Y1, X1, Y2, X2), X2>x_max.
%:- camino(Y1, X1, Y2, X2), Y1>y_max.
%:- camino(Y1, X1, Y2, X2), X1>x_max.

%:- camino(Y1, X1, Y2, X2), Y2<1.
%:- camino(Y1, X1, Y2, X2), X2<1.
%:- camino(Y1, X1, Y2, X2), Y1<1.
%:- camino(Y1, X1, Y2, X2), X1<1.

%los caminos no pueden atravezar otros nodos



% no pueden llegar 2 caminos a una misma celda
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), X1!=X2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), X1!=X2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), Y1!=Y2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), Y1!=Y2 , columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).

:- lleguen_2_caminos_a_una_celda(Y3, X3), fila(X3), columna(Y3).




#show color/3.
#show camino/5.