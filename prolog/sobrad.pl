sõbrad(Isikud):-
	Isikud = [
        isik(ants, _, _, _),
        isik(jüri, _, _, _),
        isik(mati, _, _, _)
	],
    member(isik(ants, punane, _, _), Isikud),
    member(isik(jüri, _, korvpall, _), Isikud),
    member(isik(_, sinine, _, kana), Isikud),
    member(isik(_, roheline, _, kanaarilind), Isikud),
    member(isik(_, _, jalgpall, koer), Isikud)
    .

% sõbrad(L), member(isik(X, punane, Ala), L).

% sõbrad(L), member(isik(X, _, tennis, _), L).

% ?????????????