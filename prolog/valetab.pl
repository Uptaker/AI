% defineeri paaridena, milline nädalapäev teisele järgneb
paev(e, t).
paev(t, k).
paev(k, n).
paev(n, r).
paev(r, l).
paev(l, p).
paev(p, e).

% kuva kolmap2evale järgnev päev - paev(k, X).

% kuva kolmapäevale eelnev päev - paev(X, k).

% küsi kõik olemasolevad nädalapäevad paev(X, Y). ???

% ülehomme funktsioon

ulehomme(A, B):-
    paev(A, X), paev(X, B).

% ülehomme 2x järjest ulehomme(t, X), ulehomme(X, Y).

% Alice ülesanne --------------------------------
% Märgi ülesse päevad, mil lõvi valetab

lvaletab(e).
lvaletab(t).
lvaletab(k).

% koosta funktsioon, millal lõvi räägib tõtt

leivaleta(X):-
    paev(X, _), \+lvaletab(X).

% kõik päevad - leivaleta(X).
% kas sel päeval valetab - leivaleta(k).

% kuva päevad, kus lõvi eelmisel päeval rääkis tõtt

leilerääkistõtt(X):-
    paev(X, _), paev(Z, X), \+lvaletab(Z).

% kuva puhkepäevad (läbi kahe valemi)

puhkepäev(X):-
	paev(r, X).

puhkepäev(X):-
    paev(X, e).

lõviütlebeilevaletab(X):-
    leivaleta(X), paev(Y, X), lvaletab(Y).