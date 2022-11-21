# faktid
kass(miisu).
kass(liisu).
emane(miisu).

isane(X):-
	\+emane(X).

# küsimused
kass(X).

kass(X), emane(X).

kass(X), isane(X).