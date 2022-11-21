lause --> nimetus, tegevus.
    
tegevus --> [jookseb].
tegevus --> [magab].
tegevus --> [_].

omadus --> [unine]; [virk]; [hoolas].

nimetus --> parisnimi.
nimetus --> omadus, parisnimi.

parisnimi --> [mari].
parisnimi --> [peeter].

% Päring: phrase(lause, [Kes, Teeb]).

% phrase(lause, [X, Y, Z]).

% phrase(lause, [unine, peeter, ujub]).

% genereerige sõnalised arvud kahekümnest kuni 99ni
% kontrollige, kas sisestatud arvsõna on korrektne

kahekohaline --> kümneline, üheline.

üheline --> [üks]; [kaks]; [kolm]; [neli]; [viis]; [kuus]; [seitse]; [kaheksa]; [üheksa].

kümneline --> [kakskümmend]; [kolmkümmend]; [nelikümmend]; [viiskümmend];
    [kuuskümmend]; [seitsekümmend]; [kaheksakümmend]; [üheksakümmend].