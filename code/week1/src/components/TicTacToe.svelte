<script lang="ts">
  import {slide} from 'svelte/transition'
  import {onMount} from 'svelte'
  import type {Position} from './TicTacToe'
  import {deepCopy, getBlankState, Type, winCombos} from './TicTacToe'

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
      move(bestPosition, AIPlayer)
      }
    }

  function checkWin(who: Type, board = states): number[][] {
    return winCombos.find(combos => combos.filter(combo => board[combo[0]][combo[1]].type === who).length === 3)
  }

  function bestSpot(): Position {
    // return emptyPositions()[0]
    return miniMax(states, AIPlayer) as Position
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

      // might be wrong
      // reset board to what it was before, push result to array
      newBoard[availablePositions[i].row][availablePositions[i].column] = move
      moves.push(move)
    }
    console.log(moves)

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

  function emptyPositions(board = states): Position[] {
    return [].concat.apply([], board).filter(pos => pos.type === Type.BLANK)
  }

  function checkTie(): Boolean {
    return emptyPositions().length === 0
  }

</script>

<div class="container" style="margin-bottom: 5px">

  <div class="board" >

    {#if winningMove}
      <h2 transition:slide>{states[winningMove[0][0]][winningMove[0][1]].type} won</h2>
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

  .container {
    display: flex;
    justify-content: center;
  }

  .board {
    background-color: sandybrown;
  }
</style>