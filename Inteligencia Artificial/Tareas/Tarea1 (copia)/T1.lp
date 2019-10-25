#const y_max=5.
#const x_max=5.

rangoX(x_max).
rangoY(y_max).

fila(1..5).
columna(1..5).

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

misma_celda(X1, Y1, X2, Y2) :- fila(Y1), fila(Y2), columna(X1), columna(X2), X1==X2, Y1==Y2.

diferemte_celda(X1, Y1, X2, Y2) :- not misma_celda(X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).

celdas_inicio(X1, Y1) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).
celdas_termino(X2, Y2) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).
color_celdas_inicio(C, X1, Y1) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).
color_celdas_termino(C, X2, Y2) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).

celdas_fijas(X1, Y1) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).
celdas_fijas(X2, Y2) :- camino_inicio_fin(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).

%todo camino tiene 1 inicio y un fin 
1{camino_inicio_fin(C, X1, Y1, X2, Y2): color(C, X1, Y1), color(C, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2)}1 :- colores(C).

% 1 solo inicio 
1{camino(C, X1, Y1, X3, Y3): fila(Y3), columna(X3)}1 :-  camino_inicio_fin(C, X1, Y1, X2, Y2).

% 1 solo fin 
1{camino(C, X3, Y3, X2, Y2): fila(Y3), columna(X3)}1 :- camino_inicio_fin(C, X1, Y1, X2, Y2).

% inicio != fin
:- camino_inicio_fin(C, X1, Y1, X2, Y2), X1==X2, Y1==Y2.

% destino camino != celdas iniciales
:- camino(C, X1, Y1, X2, Y2), celdas_inicio(X2, Y2), colores(C), fila(Y1), fila(Y2), columna(X1), columna(X2).

% el destino de 2 caminos no puede ser el mismo 
:- camino(C1, X1, Y1, X3, Y3), camino(C2, X2, Y2, X3, Y3), diferemte_celda(X1, Y1, X2, Y2), colores(C1), colores(C2), fila(Y1), fila(Y2), fila(Y3), columna(X3), columna(X1), columna(X2).


% no pueden salir 2 caminos de una misma celda
:- camino(C, X3, Y3, X2, Y2), camino(C2, X3, Y3, X1, Y1), diferemte_celda(X1, Y1, X2, Y2), colores(C1), colores(C2).

% hay solo 1 camino que llega a cada celda 
1{camino(C, X1, Y1, X2, Y2) : columna(X1), fila(Y1), colores(C)}1 :- columna(X2), fila(Y2), not celdas_inicio(X2, Y2). 


% celdas aledañas
1{aledanias(X1, Y1, X2, Y2) : X1 + Y1 - X2 - Y2 = 1; X1 + Y1 - X2 - Y2 = -1}1 :- camino(C, X1, Y1, X2, Y2).
1{aledanias(X1, Y1, X2, Y2) : X1 - X2 <= 1, X1 - X2 >= -1,  Y1 - Y2 <= 1, Y1 - Y2 >= -1}1 :- camino(C, X1, Y1, X2, Y2).
%1{aledanias(X1, Y1, X2, Y2) : X1 == X2; Y1 == Y2}1 :- camino(C, X1, Y1, X2, Y2).
 
:- not aledanias(X1, Y1, X2, Y2), camino(C, X1, Y1, X2, Y2), fila(Y1), fila(Y2), columna(X1), columna(X2).

% para toda celda inicial parte un camino del mismo color
1{camino(C, X1, Y1, X2, Y2): fila(Y2), columna(X2)}1 :- celdas_inicio(X1, Y1), color(C, X1, Y1), colores(C).

% para toda celda final, un camino del mismo color llega a ella 
1{camino(C, X1, Y1, X2, Y2): fila(Y1), columna(X1)}1 :- celdas_termino(X2, Y2), color(C, X2, Y2).

% todo camino posee un solo inicio y un solo fin del mismo color 
%%1{camino(C, X1, Y1, X2, Y2): fila(Y2), columna(X2)}
%1{camino(C, X1, Y1, X2, Y2): fila(Y1), columna(X1)}1 :- celdas_termino(X2, Y2), color(C, X1, Y1), colores(C).

% todo camino no inicial esta conectado con un camino anterior 
1{camino(C, X1, Y1, X2, Y2): fila(Y1), columna(X1)}1 :- not celdas_inicio(X2, Y2), color(C, X2, Y2), colores(C).

% todo camino no final esta conectado con a un camino posterior 
1{camino(C, X1, Y1, X2, Y2): fila(Y2), columna(X2)}1 :- not celdas_termino(X1, Y1), color(C, X1, Y1), colores(C).

% no salen caminos de la celda de termino 
:- camino(C, X1, Y1, X2, Y2), celdas_termino(X1, Y1),  fila(Y1), fila(Y2), columna(X1), columna(X2), colores(C).


%la celda siguietne debe tener el mismo color que la anterior 
%camino(C, X, Y, X-1, Y) :- color(C, X, Y),  not celdas_fijas(X-1, Y), fila(X),  columna(X-1), fila(Y), colores(C), fila(Y1), columna(X1).
%camino(C, X, Y, X-1, Y) :- camino(C, X1, Y1, X, Y),  not celdas_fijas(X-1, Y),  columna(X-1), fila(Y), colores(C), fila(Y1), columna(X1).

%camino(C, X, Y, X-1, Y) :- color(C, X, Y),  not celdas_fijas(X-1, Y), fila(X),  fila(X-1), columna(Y), colores(C).
%camino(C, X, Y, X-1, Y) :- camino(C, X1, Y1, X, Y),  not celdas_fijas(X-1, Y),  fila(X-1), columna(Y), colores(C).

%camino(C, X, Y, X, Y+1) :- color(C, X, Y),  not celdas_fijas(X, Y+1), fila(X),  fila(X), columna(Y+1), colores(C).
%camino(C, X, Y, X, Y+1) :- camino(C, X1, Y1, X, Y),  not celdas_fijas(X, Y+1),  fila(X), columna(Y+1), colores(C).

%camino(C, X, Y, X, Y-1) :- color(C, X, Y),  not celdas_fijas(X, Y-1), fila(X),  fila(X), columna(Y-1), colores(C).
%camino(C, X, Y, X, Y-1) :- camino(C, X1, Y1, X, Y),  not celdas_fijas(X, Y-1),  fila(X), columna(Y-1), colores(C).



%camino(C, X, Y, X-1, Y) :- color(C, X, Y), not celdas_fijas(X-1, Y), fila(X-1), columna(Y), colores(C).
%camino(C, X, Y, X, Y+1) :- color(C, X, Y), not celdas_fijas(X, Y+1), fila(X), columna(Y+1), colores(C).
%camino(C, X, Y, X, Y-1) :- color(C, X, Y), not celdas_fijas(X, Y-1), fila(X), columna(Y-1), colores(C).
%
%color(C, X2, Y2) :- camino()


#show color/3.
#show camino/5.


