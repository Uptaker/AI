<script lang="ts">

  enum Type {
    TILE = 'T', EDGE = 'E', HORIZONTAL = 'X', UP ='Y', VERTICAL = 'Z', FINISH = 'F'
  }

  interface Position {
    row: number,
    column: number
  }

  interface Tile {
    type: Type,
    wayX?: Position
    wayY?: Position
    wayZ?: Position
  }

  function findPlayerPosition(): Position {
    let row, column
    row = state.findIndex((row) => row.find((c, index) => {
      column = index
      return c.type === Type.VERTICAL || c.type === Type.UP || c.type === Type.VERTICAL
    }))
    return {row, column}
  }



  let player
  const stateAsStrings: string[] = [
          'TTZTTEEEEE',
          'TTTEEEETFT',
          'TTTTEETTTT',
          'TTTTTTTTTE',
          'ETTTTTTEEE',
          'EEETTTTEEE'
  ]

  const state: Tile[][] = initState(stateAsStrings)

  /*
  function explore() {
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

  */

  function initState(strings: string[]): Tile[][] {
    let startingState: Tile[][] = []
    strings.forEach(r => {
      const row = []
      const column = r.split("")
      column.forEach(c => row.push({type: c} as Tile))
      startingState.push(row)
    })
    return startingState
  }
  
  function color(value: Tile, row: number, column: number) {
    switch (value.type) {
      case Type.TILE: return colorByAdjacentType(row, column)
      case Type.EDGE: return 'black'
      case Type.FINISH: return 'green'
      default: return 'blue'
    }
  }

  function colorByAdjacentType(row, column): string {
    if (state[row]?.at(column - 1)?.type === Type.HORIZONTAL) return '#5FA1D5FF'
    else if (state[row - 1]?.at(column)?.type === Type.VERTICAL) return '#5FA1D5FF'
    else return 'white'
  }
  
</script>

<div class="board" style="margin-bottom: 5px">
  {#if state}
    <div class="row">
      {#each state as row, i}
        <div class="column">
          {#each row as value, j}
            <div class="square" style="background-color: {color(value, i, j)}"></div>
          {/each}
        </div>
      {/each}
    </div>
  {/if}
</div>

<button on:click={findPlayerPosition}>Move</button>

<style>
  .row {
    display: flex;
    flex-direction: column;
  }

  .column {
    display: flex;
  }

  .square {
    width: 50px;
    height: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #d0d0d0
  }

  .board {
    width: min-content;
    margin: 0 auto;
  }
</style>
