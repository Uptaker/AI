<script lang="ts">
  import {onMount} from 'svelte'
  import type {State} from './TicTacToe'
  import {blankState, Type, winCombos} from './TicTacToe'

  let humanPlayer = Type.X
  let AIPlayer = Type.O
  let states: State[][]
  let winningMove: number[][]

  onMount(() => {
    freshState()
    console.log(states)
  })

  function freshState() {
    states = blankState()
    winningMove = undefined
  }

  function move(row: number, column: number, turn = AIPlayer) {
    if (states[row][column] !== Type.BLANK) return
    states[row][column] = turn
    let winningTurn = checkWin(turn)
    if (winningTurn) winningMove = winningTurn
    console.log(winningMove)
  }

  function checkWin(who: Type) {
    return winCombos.find(combos => combos.filter(combo => states[combo[0]][combo[1]] === who).length === 3)
  }

</script>

<div class="board" style="margin-bottom: 5px">
  {#if winningMove}
    <h2>{states[winningMove[0][0]][winningMove[0][1]]} won</h2>
  {/if}
  {#if states}
    <div class="column">
      {#each states as row, i}
        <div class="row">
          {#each row as value, j}
            <div class="square" on:click={() => move(i, j, humanPlayer)} class:winning={winningMove?.find(turn => turn[0] === i && turn[1] === j)}>
              {#if value !== Type.BLANK}
                <div class="state">{value}</div>
              {/if}
            </div>
          {/each}
        </div>
      {/each}
    </div>
  {/if}
</div>

<button on:click={freshState}>{winningMove ? 'Play again' : ' Reset'}</button>


<style>
  .row {
    display: flex;
    gap: 3px;
  }

  .winning {
    background-color: darkseagreen !important;
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
    transition: opacity 0.3s ease-out;
  }

  .square:hover {
    opacity: 50%;
  }

  .board {
    width: min-content;
    margin: 0 auto;
  }
</style>