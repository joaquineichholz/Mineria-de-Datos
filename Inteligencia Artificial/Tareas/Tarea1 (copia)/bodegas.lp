#const bound = 11.
time(1..bound).

% hay 5 acciones posibles
action(up).
action(down).
action(left).
action(right).
action(wait).

%exec(R,A,T) significa que R ejecuta la accion A en T

%R está en (X,Y) en tiempo T si es que R está en Xp,Yp en T-1 y
%ejecutas A y X,Y se obtiene del delta
on(R,X-1,Y,T) :- exec(R,left,T-1),on(R,X,Y,T-1),time(T).
on(R,X+1,Y,T) :- exec(R,right,T-1),on(R,X,Y,T-1),time(T).
on(R,X,Y+1,T) :- exec(R,up,T-1),on(R,X,Y,T-1),time(T).
on(R,X,Y-1,T) :- exec(R,down,T-1),on(R,X,Y,T-1),time(T).
on(R,X,Y,T) :- exec(R,wait,T-1),on(R,X,Y,T-1),time(T).

% cada robot puede ejecutar una acción en cada instante de tiempo
1{exec(R,A,T-1) : action(A)} 1 :- robot(R),time(T).

at_goal(R,T) :- on(R,X,Y,T),goal(R,X,Y).

% goal(1,X,Y) : 1 está en X,Y
% quiero decir que robot 1 está en su objetivo
% definido por goal(1,X,Y) (más abajo)
:- robot(R),not at_goal(R,bound).

:- on(R1,X1,Y1,T),on(R2,X2,Y2,T),
   on(R2,X1,Y1,T-1),on(R1,X2,Y2,T-1),R1!=R2.

:- on(R,X,Y,T),on(Rp,X,Y,T),R!=Rp.
:- on(R,X,Y,T),obstacle(X,Y).
:- on(R,X,Y,T),not rangeX(X).
:- on(R,X,Y,T),not rangeY(Y).


#show on/4.
#show obstacle/2.
#show rangeX/1.
#show rangeY/1.
#show exec/3.
#show goal/3.

%%%%% Definición del problema

% entre que valores se mueven X e Y
rangeX(0..4).
rangeY(0..4).

%obstacle(1,1..6).
%obstacle(3,1..6).
obstacle(6,6).

robot(1..5).
on(1,0,2,0).
on(2,0,3,0).
on(3,0,4,0).
on(4,2,4,0).
on(5,3,4,0).
%on(6,4,5,0).

%on(R, X, Y, T-1) :- robot(R), rangeX(X), rangeY(Y), time(T).


% goal(R,X,Y): el robot R debe llegar a X,Y
goal(1,2,4).
goal(2,4,3).
goal(3,2,2).
goal(4,3,2).
goal(5,4,2).
%goal(6,3,1).
