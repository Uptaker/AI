qS --> [a], qB.
qS --> [b], qA.
qA --> [a].
qA --> [a], qS.
qA --> [b], qA, qA.
qB --> [b].
qB --> [b], qS.
qB --> [a], qB, qB.

% L = [a, b, b, a], phrase(qS, L). check if 'abba' works

% L = [_, _, _, _, _, _], phrase(qS, L). possible 6-letter variants