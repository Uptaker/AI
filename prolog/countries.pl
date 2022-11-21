varv(kollane).
varv(punane).
varv(sinine).
varv(roheline).

piir(Riik1, Riik2):-
    varv(Riik1), varv(Riik2),
    Riik1 \= Riik2.

% kuva, kus Eesti on alati sinine: Eesti = sinine, piir(Eesti, Läti).

otsing():-
    piir(Eesti, Läti),
    piir(Eesti, Venemaa),
    piir(Läti, Venemaa),
    piir(Leedu, Venemaa),    
    piir(Läti, Leedu),
    piir(Leedu, Poola),
    piir(Poola, Tšehhi),
    piir(Tšehhi, Saksamaa),
    piir(Saksamaa, Austria),
    piir(Poola, Saksamaa),
    piir(Austria, Tšehhi),
    
    
    writeln(Eesti + Venemaa + Läti + Leedu + Poola + Tšehhi + Saksamaa + Austria),
    !.

% Uurige Euroopa kaarti. Otsime kümmekond riiki koos kokkupuutumistega
% Laske riigid võimalikult väheste värviega värvida

% kuva riigi värvid - otsing.