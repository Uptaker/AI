<script lang="ts">
    import {onMount} from "svelte";

    let kp = 8;
    let vastus: string
    let praeguneSeis =
            ("XXXXXXXX" +
            "X.X....X" +
            "XXX..F.X" +
            "XXX.XXXX" +
            "X.X....X" +
            "X..XX..X" +
            "XS.....X" +
            "XXXXXXXX").split("");

    function formattedState(praeguneSeis) {
        let v = "";
        console.log(praeguneSeis);
        let kSeis = praeguneSeis.join("");
        for (let i = 0; i < 9; i++) {
            v += kSeis.substring(i * 8, i * 8 + 8) + "\n"
        }
        return v
    }

    onMount(() => uuri())

    let lubatudSammud = [-1, 1, -kp, kp];

    //let tagasiSuunad={-1:"&gt;", 1:"&lt;", -kp:"v", kp:"^"};
    function leiaVabad(koht) {
        let v = [];
        lubatudSammud.forEach((samm) => {
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
            vabad.forEach((koht) => {
                let vahe = koht - uuritav;
                let symbol = "?";
                if (vahe == -1) symbol = "p"
                if (vahe == 1) symbol = "v"
                if (vahe == -kp) symbol = "a"
                if (vahe == kp) symbol = "y"
                praeguneSeis[koht] = symbol;
                hallid.push(koht)
            })
        }

        //replace with o
        const arvud = {v: -1, p: 1, a: kp, y:-kp}
        if (praeguneSeis[loppkoht] != ".") {
            let koht = loppkoht
            while (koht != algkoht) {
                let symbol = praeguneSeis[koht]
                let uusKoht =  koht + arvud[symbol]
                praeguneSeis[koht] = 'o'
                koht = uusKoht
            }
        }

        for (let nr = 0; nr < kp * kp; nr++) {
            if (praeguneSeis[nr] in arvud) {
                praeguneSeis[nr] = '.'
            }
        }
        vastus = (praeguneSeis[loppkoht] == ".") ? "Ei" : "Jah";
    }

    /*  V??ljasta, kas on v??imalik liikuda stardist fini??isse
      vihjed: leia fini??i koha number
      asenda koht punktiga
      p??rast ala t??itmist kontrolli, kas fini??i kohal on t??rn
    */
    //T??hista teekond Fini??ist Starti o-t??htedega
</script>

<pre>
{formattedState(praeguneSeis)}
</pre>

{vastus}
