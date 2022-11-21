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