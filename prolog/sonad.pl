algus(q0).
ots(q3).
seos(q0, q1, 1).
seos(q1, q0, 1).
seos(q1, q3, 0).
%seos(q3, q1, 0).

kahene():-
    algus(X), seos(X, Y, A), seos(Y, _, B),
	write(A), writeln(B), false.

neljane():-
    algus(X), seos(X, Y, A), seos(Y, Z, B),
    seos(Z, V, C), seos(V, W, D),
	write(A), write(B), write(C), write(D), false.

% kuvage kõik neljasammulised sõnad
% püüdke ehitada skeem selliselt, et aktsepteeritavaid
% neljasammulisi sõnu on kaks tükki