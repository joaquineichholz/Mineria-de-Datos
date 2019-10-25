fila(1..15).
columna(1..15).
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
% Se definen los colores disponibles
colores(C):- color(C, Y, X), fila(Y), columna(X). 

% Definimos arbitrariamente un celda_inicio y un fin 
1{celda_inicio(C, X1, Y1)}1 :- color(C, X1, Y1), color(C, X2, Y2), columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C), Y1 != Y2, Y1<Y2.
1{celda_inicio(C, X1, Y1)}1 :- color(C, X1, Y1), color(C, X2, Y2), columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C), Y1 = Y2, X1!=X2, X1<X2.

celda_termino(C, X1, Y1) :- color(C, X1, Y1), not celda_inicio(C, X1, Y1).



%% restriccion tomada de bodegas.lp
% del celda_inicio ejecutas 1 movimeinto en 1 espacio
1{  camino(C, Y, X, Y + 1, X);
    camino(C, Y, X, Y - 1, X) ; 
    camino(C, Y, X, Y, X + 1 ) ; 
    camino(C, Y, X, Y, X - 1)}1 :- celda_inicio(C, Y, X), fila(Y), columna(X).

% de cada camino ejecutas 1 movimeinto en 1 espacio
1{  camino(C, Y2, X2, Y2 + 1, X2); 
    camino(C, Y2, X2, Y2 - 1, X2); 
    camino(C, Y2, X2, Y2, X2 + 1);
    camino(C, Y2, X2, Y2, X2 - 1)}1 :- camino(C,Y1,X1,Y2,X2), fila(Y1), columna(X1), fila(Y2), columna(X2), colores(C), not celda_termino(C, Y2, X2).   


% el camino no puede salirse de los bordes

:- camino(C, Y1, X1, Y2, X2), not columna(X1). 
:- camino(C, Y1, X1, Y2, X2), not columna(X2). 
:- camino(C, Y1, X1, Y2, X2), not fila(Y1). 
:- camino(C, Y1, X1, Y2, X2), not fila(Y2). 


% toda casilla debe ser ocupada por un camino

% si un camino sale de una celda, pasa un camino 
pasa_camino(Y, X) :- camino(C, Y1, X1, Y, X), colores(C), fila(Y1), fila(Y), columna(X1), columna(X). 

% si un camino llega a una celda, pasa un camino 
pasa_camino(Y1, X1) :- camino(C, Y1, X1, Y, X), colores(C), fila(Y1), fila(Y), columna(X1), columna(X). 

:- fila(Y), columna(X), not pasa_camino(Y, X). 


% No hay 2 caminos que partan desde la misma celda 


%%%%%%%%%%%%%%%%
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), Y1!=Y2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), X1!=X2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).

:- lleguen_2_caminos_a_una_celda(Y3, X3), columna(X3), fila(Y3).

salgan_2_caminos_de_una_celda(Y3, X3) :- camino(C1, Y3, X3, Y1, X1), camino(C2, Y3, X3, Y2, X2), Y1!=Y2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).
salgan_2_caminos_de_una_celda(Y3, X3) :- camino(C1, Y3, X3, Y1, X1), camino(C2, Y3, X3, Y2, X2), X1!=X2 , fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C1), colores(C2).

:- salgan_2_caminos_de_una_celda(Y3, X3), columna(X3), fila(Y3).
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%

%no puede salir un camino de un color distinto al de la celda
:- camino(C1, X1, Y1, X2, Y2), color(C2, X1, Y1), C1!=C2, columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).
:- camino(C1, X1, Y1, X2, Y2), color(C2, X2, Y2), C1!=C2, columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).
%%%%%%%%%%%%%%%


#show camino/5.
#show color/3.
