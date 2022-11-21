laps(toomas, jaagup).
laps(paula, jaagup).

laps(jaagup, pille).
laps(jaagup, vello).

laps(pille, aleksander).
laps(viivi, aleksander).

% lapselapsed
lapselaps(A, B):-
    laps(A, X), laps(X, B).

% õed-vennad
ove(A, B):-
    laps(A, X), laps(B, X),
    A\=B.

% tädid ja onud
tadionu(A, B):-
    laps(B, X), ove(X, A).

% jaagupi lapsed - laps(X, jaagup).
% pille lapsed - laps(X, pille).