<script lang="ts">
  import {onMount} from 'svelte'
  import type {Position} from './TicTacToe'
  import {getBlankState, Type, winCombos} from './TicTacToe'

  let humanPlayer = Type.X
  let AIPlayer = Type.O
  let states: Position[][]
  let winningMove: number[][]

  onMount(() => freshState())

  function freshState() {
    states = getBlankState()
    winningMove = undefined
  }

  function move(pos: Position, turn = AIPlayer) {
    if (states[pos.row][pos.column].type !== Type.BLANK || winningMove) return
    states[pos.row][pos.column].type = turn
    let winningTurn = checkWin(turn)
    if (winningTurn) winningMove = winningTurn
    if (turn === humanPlayer && !winningTurn && !checkTie()) {
      const bestPosition = bestSpot()
      console.log(bestPosition)
      move(bestPosition, AIPlayer)
      }
    }

  function checkWin(who: Type) {
    return winCombos.find(combos => combos.filter(combo => states[combo[0]][combo[1]].type === who).length === 3)
  }

  function bestSpot() {
    return emptyPositions()[0]
  }

  function emptyPositions(): Position[] {
    return [].concat.apply([], states).filter(pos => pos.type === Type.BLANK)
  }

  function checkTie() {

  }

</script>

<div class="board" style="margin-bottom: 5px">
  {#if winningMove}
    <h2>{states[winningMove[0][0]][winningMove[0][1]].type} won</h2>
  {/if}
  {#if states}
    <div class="column">
      {#each states as row, i}
        <div class="row">
          {#each row as value, j}
            <div class="square" on:click={() => move({row: i, column: j}, humanPlayer)} class:winning={winningMove?.find(turn => turn[0] === i && turn[1] === j)}>
              {#if value.type !== Type.BLANK}
                <div class="state">{value.type}</div>
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