% korrutustabel, kus vastus (C) on 10 ja 15 vahel
between(2, 4, A), between(1, 5, B), C is A*B, between(10, 15, C).

% Leidke kõik arvud, mis vastavad valemile a*a + 7 ja on < 100
between(0, 10, A), B is A*A+7, between(1, 99, B).

%  A B 10
%  C D 10
% 10 10
% Maagiline ruut. Leia A, B, C, D võimalikud väärtused.

ruut2(A, B, C, D):-
    between(1, 9, A), between(1, 9, B), between(1, 9, C), between(1, 9, D),
    10 is A+B, 10 is A+C, 10 is C+D, 10 is B+D.

ruut2(A, B, C, D).

% Annab võimalikud arvud, mille puhul listi (3, Y, X) summa on 18
between(1, 10, X), between(1, 10, Y), L = [3, Y, X], sumlist(L, V), V = 18.

% 3x3 maagiline ruut, kus ridade ja veergude summaks on etteantud arv (nt 10)
ruut3(A, B, C, D, E, F, G, H, I):-
    between(1, 9, A), between(1, 9, B), between(1, 9, C),
    between(1, 9, D), between(1, 9, E), between(1, 9, F),
    between(1, 9, G), between(1, 9, H), between(1, 9, I),
    10 is A+B+C, 10 is D+E+F, 10 is G+H+I,
    10 is A+D+G, 10 is B+E+H, 10 is C+F+I.