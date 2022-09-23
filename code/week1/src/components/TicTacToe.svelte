<script lang="ts">
  import {slide} from 'svelte/transition'
  import {onMount} from 'svelte'
  import type {Position} from './TicTacToe'
  import {deepCopy, getBlankState, Type, winCombos} from './TicTacToe'

  interface Status {
    tie: boolean
    winner?: number[][]
  }

  let humanPlayer = Type.X
  let AIPlayer = Type.O
  let state: Position[][]
  let status: Status = {tie: false}

  onMount(() => freshState())

  function freshState() {
    state = getBlankState()
    status = {tie: false}
  }

  function move(pos: Position, turn = AIPlayer) {
    if (state[pos.row][pos.column].type !== Type.BLANK || status?.winner || status.tie) return
    state[pos.row][pos.column].type = turn
    status.winner = checkWin(turn)
    status.tie = checkTie()
    if (turn === humanPlayer && !status?.winner && !status.tie) {
      const bestPosition = bestSpot()
      move(bestPosition, AIPlayer)
      }
    }

  function checkWin(who: Type, board = state): number[][] {
    return winCombos.find(combos => combos.filter(combo => board[combo[0]][combo[1]].type === who).length === 3)
  }

  function bestSpot(): Position {
    // return emptyPositions()[0]
    return miniMax(state, AIPlayer) as Position
  }

  function miniMax(board: Position[][], player: Type): Position | {score: number} {
    const newBoard = deepCopy(board)
    const availablePositions = emptyPositions(newBoard)

    // check for terminal states (win or tie)
    if (checkWin(humanPlayer, newBoard)) return {score: -10}
    else if (checkWin(AIPlayer, newBoard)) return {score: 10}
    else if (availablePositions.length === 0) return {score: 0}


    // collect the scores for each empty spot to evaluate later
    let moves: Position[] = []
    for (let i = 0; i < availablePositions.length; i++) {
      const { row, column } = newBoard[availablePositions[i].row][availablePositions[i].column]
      let move: Position = {column: newBoard[row][column].column, row: newBoard[row][column].row}
      newBoard[availablePositions[i].row][availablePositions[i].column].type = player

      // if no terminal state, keep recursively going deeper
      if (player === AIPlayer) move.score = miniMax(newBoard, humanPlayer).score
      else move.score = miniMax(newBoard, AIPlayer).score

      // reset board to what it was before, push result to array
      newBoard[availablePositions[i].row][availablePositions[i].column] = move
      moves.push(move)
    }

    // evaluate the best move
    // lowest when human playing
    // highest score when AI playing
    let bestMove
    if (player === AIPlayer) {
      let bestScore = -Infinity
      for (let i = 0; i < moves.length; i++) {
        if (moves[i].score > bestScore) {
          bestScore = moves[i].score
          bestMove = i
        }
      }
    } else {
      let bestScore = Infinity
      for (let i = 0; i < moves.length; i++) {
        if (moves[i].score < bestScore) {
          bestScore = moves[i].score
          bestMove = i
        }
      }
    }
    return moves[bestMove]
  }

  function emptyPositions(board = state): Position[] {
    return [].concat.apply([], board).filter(pos => pos.type === Type.BLANK)
  }

  function checkTie(): Boolean {
    return emptyPositions().length === 0
  }

</script>

<div class="container" style="margin-bottom: 5px">

  <div class="board" >
    {#if status?.winner}
      <h2 transition:slide>{state[status.winner[0][0]][status.winner[0][1]].type} won</h2>
    {:else if status.tie}
      <h2 transition:slide>Tie</h2>
    {/if}
    {#if state}
      <div class="column">
        {#each state as row, i}
          <div class="row">
            {#each row as value, j}
              <div class="square" on:click={() => move({row: i, column: j}, humanPlayer)} class:winning={status?.winner?.find(turn => turn[0] === i && turn[1] === j)}>
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

  </div>

<button on:click={freshState}>{status ? 'Play again' : ' Reset'}</button>


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

  .container {
    display: flex;
    justify-content: center;
  }

  .board {
    background-color: sandybrown;
  }
</style>