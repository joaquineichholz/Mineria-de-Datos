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























% Se definen los colores disponibles
colores(C):- color(C, X1, Y1), fila(X1), columna(Y1). 

% celdas de inicio y fin 

1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 != X2, X1<X2.
1{celdas_inicio(C, Y1, X1)}1 :- color(C, Y1, X1), color(C, Y2, X2), columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C), X1 = X2, Y1!=Y2, Y1<Y2.

celdas_termino(C, Y1, X1) :- color(C, Y1, X1), not celdas_inicio(C, Y1, X1).


% definimos arcos

1{camino(C,Y,X,Y+1,X);camino(C,Y,X,Y-1,X);camino(C,Y,X,Y,X+1);camino(C,Y,X,Y,X-1)}1 :- inicio(C, Y, X), fila(Y), columna(X).
1{camino(C,X2,Y2,X2+1,Y2);camino(C,X2,Y2,X2-1,Y2);camino(C,X2,Y2,X2,Y2+1);camino(C,X2,Y2,X2,Y2-1)}1 :- camino(C,X1,Y1,X2,Y2), fila(X1), columna(Y1), fila(X2), columna(Y2), colores(C), not final(C, X2, Y2).   



% camino no puede salirse de los bordes
:- camino(C, X1, Y1, X2, Y2), not columna(X1). 
:- camino(C, X1, Y1, X2, Y2), not columna(X2). 
:- camino(C, X1, Y1, X2, Y2), not fila(Y1). 
:- camino(C, X1, Y1, X2, Y2), not fila(Y2). 



% toda casilla ocupada por un camino 

pintada(Y1, X1) :- camino(C, Y1, X1, Y2, X2), colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C). 
pintada(Y1, X1) :- camino(C, Y2, X2, Y1, X1), colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C). 

:- fila(Y1), columna(X1), not pintada(Y1, X1). 

% no pueden llegar 2 caminos a una misma celda
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), X1!=X2 , columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).
lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), X1!=X2 , columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).

%lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C1, Y1, X1, Y3, X3), camino(C2, Y2, X2, Y3, X3), Y1!=Y2 , columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).
%lleguen_2_caminos_a_una_celda(Y3, X3) :- camino(C2, Y1, X1, Y3, X3), camino(C1, Y2, X2, Y3, X3), Y1!=Y2 , columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C1), colores(C2).

:- lleguen_2_caminos_a_una_celda(Y3, X3), fila(Y3), columna(X3).


% hay un camino que sale desde el inicio con el mismo color 
1{  camino(C2, Y1, X1, Y1 + 1, X1); 
    camino(C2, Y1, X1, Y1 - 1, X1); 
    camino(C2, Y1, X1, Y1, X1 + 1); 
    camino(C2, Y1, X1, Y1, X1 - 1)}1 :-  celdas_inicio(C2, Y1, X1), colores(C2).

% no salen 2 caminos de un inicio 
%:- camino(C1, Y1, X1, Y2, X2), camino(C2, Y1, X1, Y3, X3), Y2!=Y3, celdas_inicio(C3, Y1, X1), columna(Y1), columna(Y2), columna(Y3), fila(X1), fila(X2), fila(X3), colores(C1), colores(C2), colores(C3).


% hay un camino que sale desde todo camino menos del ultimo con el mismo color 
%1{  camino(C2, Y1, X1, Y1 + 1, X1); 
 %   camino(C2, Y1, X1, Y1 - 1, X1); 
  %  camino(C2, Y1, X1, Y1, X1 + 1); 
   % camino(C2, Y1, X1, Y1, X1 - 1)}1 :-  camino(C2, Y2, X2, Y1, X1), colores(C2), not celdas_termino(C2, Y1, X1).

% hay un camino que llega hasta el termino de un camino con el mismo color 
1{  camino(C2, Y1 + 1, X1, Y1, X1); 
    camino(C2, Y1 - 1, X1, Y1, X1); 
    camino(C2, Y1, X1 + 1, Y1, X1); 
    camino(C2, Y1, X1 - 1, Y1, X1)}1 :-  celdas_termino(C2, Y1, X1).


% no puede cambiar de color el camino 
:- camino(C1, Y1, X1, Y2, X2), camino(C2, Y2, X2, Y3, X3), C1!=C2, fila(Y1), fila(Y1), fila(Y3), columna(X3), columna(X1), columna(X2), colores(C).
:- camino(C1, Y2, X2, Y1, X1), camino(C2, Y2, X2, Y3, X3), C1!=C2, fila(Y1), fila(Y1), fila(Y3), columna(X3), columna(X1), columna(X2), colores(C).

% ningun camino llega al inicio 
:- camino(C1, Y1, X1, Y2, X2), celdas_inicio(C2, Y2, X2), columna(Y1), fila(X1), colores(C1).

% No puede llegar un camino de diferete color al final 
:- camino(C1, Y1, X1, Y2, X2), celdas_termino(C2, Y2, X2), C1!=C2, columna(Y1), columna(Y2), fila(X1), fila(X2), colores(C1), colores(C2).

% no puede NO haber un camino que llegue hasta e final 
%:- not camino(C, Y1, X1, Y2, X2), celdas_termino(C, Y2, X2), columna(Y1), fila(X1).





#show camino/5.
#show color/3.
%#show celdas_termino/3.
%#show camino/5.