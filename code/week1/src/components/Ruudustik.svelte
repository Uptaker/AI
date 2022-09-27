<script>
    let kp = 8;
    let praeguneSeis =
        ("XXXXXXXX" +
            "X.X....X" +
            "XXX..F.X" +
            "XXX.XXXX" +
            "X.X....X" +
            "X..XX..X" +
            "XS.....X" +
            "XXXXXXXX").split("");

    function kuva() {
        let v = "";
        console.log(praeguneSeis);
        let kSeis = praeguneSeis.join("");
        for (let i = 0; i < 9; i++) {
            v += kSeis.substring(i * 8, i * 8 + 8) + "<br />\n"
        }
        console.log(v);
        laud.innerHTML = v;
    }

    let lubatudSammud = [-1, 1, -kp, kp];

    //let tagasiSuunad={-1:"&gt;", 1:"&lt;", -kp:"v", kp:"^"};
    function leiaVabad(koht) {
        let v = [];
        lubatudSammud.forEach(function (samm) {
            if (praeguneSeis[koht + samm] == ".") {
                v.push(koht + samm);
            }
        });
        return v;
    }

    function uuri() {
        let algkoht = praeguneSeis.indexOf("S");
        let loppkoht = praeguneSeis.indexOf("F");
        praeguneSeis[loppkoht] = ".";
        let hallid = [algkoht];
        while (hallid.length > 0) {
            let uuritav = hallid.shift(); //eemaldab esimese elemendi muutujasse
            let vabad = leiaVabad(uuritav);
            vabad.forEach(function (koht) {
                let vahe = koht - uuritav;
                let symbol = "?";
                if (vahe == -1) {
                    symbol = "p"
                }
                if (vahe == 1) {
                    symbol = "v"
                }
                if (vahe == -kp) {
                    symbol = "a"
                }
                if (vahe == kp) {
                    symbol = "y"
                }
                praeguneSeis[koht] = symbol;
                hallid.push(koht);
            })
        }
        kuva();
        vastus.innerHTML = (praeguneSeis[loppkoht] == "*") ? "Jah" : "Ei";
    }

    /*  Väljasta, kas on võimalik liikuda stardist finišisse
      vihjed: leia finiši koha number
      asenda koht punktiga
      pärast ala täitmist kontrolli, kas finiši kohal on tärn
    */

    function algus() {
        kuva();
        uuri();
    }
</script>

{praeguneSeis}