<script lang="ts">
    import {onMount} from "svelte";

    let praeguneSeis =
        " N N N N" +
        ". . . . " +
        " . . . ." +
        ". . . . " +
        " . . . ." +
        ". . . . " +
        " . . N ." +
        "X X X X " +
        "X";

    onMount(() => console.log(leiaKaigud(praeguneSeis)))

    function leiaKaigud(seis) {
        let kes = seis[64];
        //Kuvage käiva kasutaja nuppude asukohanumbrid
        let kohad = [];
        for (let i = 0; i < 64; i++) {
            if (seis[i] == kes) {
                kohad.push(i)
            }
        }
        console.log('kohad', kohad)
        //iga koha kohta kuva number kummagi diagonaalkäigu jaoks
        //kontrolli, kas see koht on laual
        //kontrolli, kas see koht on vaba (seal on punkt)
        //kuva võimalikud käigud
        let kaigud = []
        for (let i = 0; i < kohad.length; i++) {
            let koht = kohad[i];
            let kuhu1 = kes == 'X' ? koht - 7 : koht + 7
            if (kasVaba(kuhu1, seis)) kaigud.push([koht, kuhu1])
            let kuhu2 = kes == 'X' ? koht - 9 : koht + 9
            if (kasVaba(kuhu2, seis)) kaigud.push([koht, kuhu2])
        }
        console.log('kaigud', kaigud);
        // tagasta funktsioonist võimalikud alamseisud
        let alamseisud = []
        kaigud.forEach((k) => {
            let m = seis.split('')
            m[k[1]] = kes
            m[k[0]] = '.'
            m[64] = kes == 'X' ? 'N' : 'X'
            alamseisud.push(m.join(''))
        })
        // Leia võtmekäigud
        // (esiotsa kasvõi X-kasutajale edasiliikuvas suunas)
        let nihked = [-7, -9, 7, 9]
        let vastane = kes == 'X' ? 'N' : 'X'
        let votmiskaigud = []
        kohad.forEach((koht) => {
            nihked.forEach((nihe) => {
                if (kasRuudus(koht + nihe, seis, vastane)) {
                    if (kasRuudus(koht + 2 * nihe, seis, '.')) votmiskaigud.push([koht, koht + 2 * nihe, koht + nihe])
                }
            })
        })
        console.log('votmisk2igud', votmiskaigud)
        if (votmiskaigud.length > 0) {
            alamseisud = []
            votmiskaigud.forEach((kaik) => {
                let m = seis.split('')
                m[kaik[0]] = '.'
                m[kaik[1]] = kes
                m[kaik[2]] = '.'
                alamseisud.push(m.join(''))
            })
        }
        return alamseisud
    }

    function seisuHinnang(seis, tase = 0) {
        let a = leiaKaigud(seis)
        if (a.length == 0) return seis[64] == 'X' ? -20 : 20
        if (tase >= 3) {
            let m = seis.substring(0, 64).split('')
            let xe = m.filter(s => s == 'X').length
            let ne = m.filter(s => s == 'N').length
            return xe - ne
        }
        let h = a.map(seis => seisuHinnang(seis, tase + 1))
        return seis[64] == 'X' ? Math.max(...h) : Math.min(...h)
    }

    function move() {
        console.log('moved')
        let m = leiaKaigud(praeguneSeis)
        if (m.length > 0) praeguneSeis = m[Math.floor(m.length * Math.random())]
        else console.log('No more turns')
    }

    // pange arvuti käima võimalikult parimat käiku
    function best() {
        let k = leiaKaigud(praeguneSeis)
        if (k.length == 0) return console.log('No more turns')
        let hinnangud = k.map(seis => seisuHinnang(seis, 0))
        let mitmes = 0
        let parimHinnang = praeguneSeis[64] == 'X' ? Math.max(...hinnangud) : Math.min(...hinnangud)
        for (let i = 0; i < k.length; i++) {
            if (hinnangud[i] == parimHinnang) mitmes = i
        }
        praeguneSeis = k[mitmes]
    }


    function kasVaba(koht, seis) {
        return kasRuudus(koht, seis, '.')
    }

    function kasRuudus(koht, seis, sisu) {
        return koht > 0 && koht < 64 && seis[koht] == sisu
    }

    function asText(seis: string) {
        let v = ''
        for (let i = 0; i < 8; i++) {
            v+= seis.substring(i*8, i*8+8) + '\n'
        }
        return v
    }
</script>

<pre>{asText(praeguneSeis)}</pre>

<button on:click={move}>Random</button>
<button on:click={best}>Best</button>
