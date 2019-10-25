#const y_max=5.
#const x_max=5.

rangoX(x_max).
rangoY(y_max).

fila(1..y_max).
columna(1..x_max).

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

colores(verde).
colores(azul).
colores(blanco).
colores(amarillo).
colores(morado).

% toda celda debe tener 1 nuevo color 
1{nuevo_color(C, X, Y) :  colores(C)}1 :- fila(X), columna(Y).

% los colores originales deben ser los nuevos tambien 
nuevo_color(C, X, Y) :- color(C, X, Y).

% cada celda coloreda debe tener un vecino del mismo color
%vecino_color(C, X+1, Y) :- color(C, X, Y), color(C, X+1, Y), fila(X1+1), columna(Y1), colores(C).
%vecino_color(C, X-1, Y) :- color(C, X, Y), color(C, X-1, Y), fila(X1-1), columna(Y1), colores(C).
%vecino_color(C, X, Y+1) :- color(C, X, Y), color(C, X, Y+1), fila(X1), columna(Y1+1), colores(C).
%vecino_color(C, X, Y-1) :- color(C, X, Y), color(C, X, Y-1), fila(X1), columna(Y1-1), colores(C).

1{vecino_color(C, X, Y): colores(C)}1 :- columna(X), fila(Y). 

%goal(C, X1, Y1, X2, Y2) :- color(C, X1, Y1), color(C, X2, Y2), X1 != X2, Y1 != Y2.)

%
vecino_color(C1, X1, Y1, X1+1, Y1) :- nuevo_color(C1, X1, Y1), columna(X1+1), fila(Y1), colores(C1), nuevo_color(C1, X1+1, Y1).
vecino_color(C1, X1, Y1, X1-1, Y1) :- nuevo_color(C1, X1, Y1), columna(X1-1), fila(Y1), colores(C1), nuevo_color(C1, X1-1, Y1).
vecino_color(C1, X1, Y1, X1, Y1+1) :- nuevo_color(C1, X1, Y1), columna(X1), fila(Y1+1), colores(C1), nuevo_color(C1, X1, Y1+1).
vecino_color(C1, X1, Y1, X1, Y1-1) :- nuevo_color(C1, X1, Y1), columna(X1), fila(Y1-1), colores(C1), nuevo_color(C1, X1, Y1-1).

% alcanzable color
% caso base, son vecinos 
camino(C, X1, Y1, X2, Y2) :- vecino_color(C, X1, Y1, X2, Y2), columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C).

%caso general, hay un vecino que es vecino del otro
camino(C, X1, Y1, X2, Y2) :- camino(C, X1, Y1, X3, Y3), vecino_color(C, X3, Y3, X2, Y2), columna(X1), columna(X2), columna(X3), fila(Y3), fila(Y1), fila(Y2), colores(C).

:- not camino(C, X1, Y1, X2, Y2), color(C, X1, Y1), color(C, X2, Y2), columna(X1), columna(X2), fila(Y1), fila(Y2), colores(C). 

% debe haber un camino que llegue a toda casilla
%1{camino(C, X1, Y2, X2, Y2): colores(C), columna(X1), fila(X2)}1 :- columna(X2), fila(Y2).

%:- alcanzable_color(C1, X1, Y1, X2, Y2), color(C1, X1, Y1), color(C2, X2, Y2), C1!=C2, colores(C2). X1!=X2, Y1!=Y2, fila(X1), columna(Y1), fila(X2), columna(Y2), colores(C1), colores(C2).


%alcanzable_color(C1, X1, Y1, X1 - 1, Y1) :- color(C1, X1, Y1), rangoX(X1 - 1), rangoY(Y1), colores(C1).
%alcanzable_color(C1, X1, Y1, X1, Y1 + 1) :- color(C1, X1, Y1), rangoX(X1), rangoY(Y1 + 1), colores(C1).
%alcanzable_color(C1, X1, Y1, X1, Y1 - 1) :- color(C1, X1, Y1), rangoX(X1), rangoY(Y1 - 1), colores(C1).

%1{camino(C, X1, Y1, X2, Y2) : alcanzable_color(C, X1, Y1, X2, Y2), rangoX(X1), rangoY(Y1)}1 :- rangoX(X2), rangoY(Y2).

#show color/3.
#show camino/5.
#show rangoY/1.
#show rangoX/1.




%vecino_derecha(C, X, Y, X+1, Y) :- color(C, X, Y), color(C, X+1, Y).
%vecino_izquierda(C, X, Y, X-1, Y) :- color(C, X, Y), color(C, X-1, Y).
%vecino_arriba(C, X, Y, X, Y+1) :- color(C, X, Y), color(C, X, Y+1).
%vecino_abajo(C, X, Y, X, Y-1) :- color(C, X, Y), color(C, X, Y-1).

%vecnino(C, X, Y) :- not vecino_derecha(C, X, Y, X+1, Y); 
%                    not vecino_izquierda(C, X, Y, X-1, Y), 
%                    not vecino_arriba(C, X, Y, X, Y+1); 
%                    not vecino_abajo(C, X, Y, X, Y-1); 
%                    colores(C), fila(X), columna(Y).





%camino(C, X1, Y1, X2, Y2) :- color(C, X1, Y1), color(C, X2, Y2). 



%camino(azul, 5, 1, 5, 2).
%camino(azul, 5, 2, 5, 3).
%camino(verde, 4, 1, 4, 2).
%camino(verde, 4, 2, 3, 2).
%camino(verde, 3, 2, 3, 1).
%camino(blanco, 5, 4, 5, 5).
%camino(blanco, 5, 5, 4, 5).
%camino(amarillo, 3, 3, 4, 3).
%camino(amarillo, 4, 3 , 4, 4).
%camino(amarillo, 4, 4, 3, 4).
%camino(morado, 2, 4, 2, 3).
%camino(morado, 2, 3, 2, 2).
%camino(morado, 2, 2, 2, 1).
%camino(morado, 2, 1, 1, 1).
%camino(morado, 1, 1, 1, 2).
%camino(morado, 1, 2, 1, 3).
%camino(morado, 1, 3, 1, 4).
%camino(morado, 1, 4, 1, 5).
%camino(morado, 1, 5, 2, 5).
%camino(morado, 2, 5, 3, 5).




%y_max * x_max {colorear(C, X, Y) : fila(X), columna(Y), colores(C)}. 

%:- colorear(C1, X, Y), colorear(C2, X, Y), fila(X), columna(Y), colores(C1), colores(C2), C1!=C2.
%:- colorear(C2, X, Y), colorear(C1, X, Y), fila(X), columna(Y), colores(C1), colores(C2),  C1!=C2.


%   :- not colorear(C, X, Y), fila(X), columna(Y), colores(C).



