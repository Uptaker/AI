<script lang="ts">
  import {onMount} from 'svelte'
  import type {State} from './TicTacToe'
  import {blankState, Type, winCombos} from './TicTacToe'

  let humanPlayer = Type.X
  let AIPlayer = Type.O
  let states: State[][]
  let winner: Type

  onMount(() => {
    freshState()
    console.log(states)
  })

  function freshState() {
    states = blankState()
    winner = undefined
  }

  function move(row: number, column: number, turn = AIPlayer) {
    if (states[row][column] !== Type.BLANK) return
    states[row][column] = turn
    if (checkWin(turn)) winner = turn
  }

  function checkWin(who: Type) {
    return winCombos.some(combos => combos.filter(combo => states[combo[0]][combo[1]] === who).length === 3)
  }

</script>

<div class="board" style="margin-bottom: 5px">
  {#if states}
    {#if !winner}
      <div class="column">
        {#each states as row, i}
          <div class="row">
            {#each row as value, j}
              <div class="square" on:click={() => move(i, j, humanPlayer)}>
                {#if value !== Type.BLANK}
                  <div class="state">{value}</div>
                {/if}
              </div>
            {/each}
          </div>
        {/each}
      </div>
    {:else}
      {winner} won
    {/if}
  {/if}
</div>

<button on:click={freshState}>{winner ? 'Play again' : ' Reset'}</button>


<style>
  .row {
    display: flex;
    gap: 3px;
  }

  .column {
    display: flex;
    flex-direction: column;
    gap: 3px;
  }

  .state {
    padding: 1px;
    font-size: 8rem;
    color: black;
  }

  .square {
    width: 150px;
    height: 150px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: antiquewhite;
  }

  .square:hover {
    opacity: 50%;
  }

  .board {
    width: min-content;
    margin: 0 auto;
  }
</style>