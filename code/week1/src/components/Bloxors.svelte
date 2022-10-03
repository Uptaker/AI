<script lang="ts">
  import {onMount} from 'svelte'

  enum Type {
    TILE = 'T', EDGE = 'E', HORIZONTAL = 'X', UP ='Y', VERTICAL = 'Z', FINISH = 'F'
  }

  enum Direction {
    UP, DOWN, LEFT, RIGHT, ANY
  }

  interface Tile {
    type: Type,
    wayX: Direction
    wayY: Direction
    wayZ: Direction
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

  onMount(() => {
    console.log(state)
  })

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
    if (state[row][column - 1]?.type === Type.HORIZONTAL) return '#5FA1D5FF'
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
