<script lang="ts">
  import {slide} from 'svelte/transition'
  import type {Position, Status} from './TicTacToe'
  import {AiMode, deepCopy, flatten, getBlankState, Type, winCombos} from './TicTacToe'

  let humanPlayer = Type.X
  let AIPlayer = Type.O

  let AIMode = AiMode.MINIMAX
  let boardState: Position[][]
  let status: Status = {tie: false}

  $: if (humanPlayer) {
    AIPlayer = humanPlayer === Type.X ? Type.O : Type.X
    freshState()
  }

  function freshState() {
    boardState = getBlankState()
    status = {tie: false}
    if (AIPlayer === Type.X) move(bestSpot(), AIPlayer)
  }

  function bestSpot(): Position {
    return AIMode === AiMode.DUMB ? emptyPositions()[0] : miniMax(boardState, AIPlayer) as Position
  }

  function emptyPositions(board = boardState): Position[] {
    return flatten(board).filter(pos => pos.type !== Type.X && pos.type !== Type.O)
  }

  function checkTie(positions = emptyPositions()): Boolean {
    return positions.length === 0
  }

  function checkWin(who: Type, board = boardState): Position[] | undefined {
    const turns = flatten(board).filter(pos => winCombos.find(combos => combos.filter(combo => board[combo[0]][combo[1]].type === who).length === 3)?.find(c => c[0] === pos.row && c[1] === pos.column))
    return turns.length ? turns : undefined
  }

  function move(pos: Position, turn = AIPlayer) {
    if (boardState[pos.row][pos.column].type !== Type.BLANK || status?.winner || status.tie) return
    boardState[pos.row][pos.column].type = turn
    status.winner = checkWin(turn)
    status.tie = checkTie()
    if (turn === humanPlayer && !status?.winner && !status.tie) move(bestSpot(), AIPlayer)
  }

  function miniMax(board: Position[][], player: Type): Position | {score: number} {
    const newBoard = deepCopy(board)
    const availablePositions = emptyPositions(newBoard)

    // check for terminal states (win or tie)
    if (checkWin(humanPlayer, newBoard)) return {score: -10}
    else if (checkWin(AIPlayer, newBoard)) return {score: 10}
    else if (checkTie(availablePositions)) return {score: 0}

    // collect the scores for each empty spot to evaluate later
    let moves: Position[] = []
    for (let i = 0; i < availablePositions.length; i++) {
      const { row, column } = newBoard[availablePositions[i].row][availablePositions[i].column]
      let move: Position = {column, row}
      newBoard[row][column].type = player

      // if no terminal state, keep recursively going deeper
      if (player === AIPlayer) move.score = miniMax(newBoard, humanPlayer).score
      else move.score = miniMax(newBoard, AIPlayer).score

      // reset board to what it was before, push result to array
      newBoard[row][column] = move
      moves.push(move)
    }

    // evaluate the best move
    let bestMove: Position
    if (player === AIPlayer) {
      // highest score when AI playing
      let bestScore = -Infinity
      for (let i = 0; i < moves.length; i++) {
        if (moves[i].score > bestScore) {
          bestScore = moves[i].score
          bestMove = moves[i]
        }
      }
    } else {
      // lowest when human playing
      let bestScore = Infinity
      for (let i = 0; i < moves.length; i++) {
        if (moves[i].score < bestScore) {
          bestScore = moves[i].score
          bestMove = moves[i]
        }
      }
    }

    return bestMove
  }
</script>

<div class="container" style="margin-bottom: 5px">
  <div class="board">

    {#if status?.winner?.length}
      <h2 transition:slide>{status.winner[0].type} won</h2>
    {:else if status.tie}
      <h2 transition:slide>Tie</h2>
    {/if}
    {#if boardState}
      <div class="column">
        {#each boardState as row, i}
          <div class="row">
            {#each row as value, j}
              {@const win = status.winner?.find(s => s.row === i && s.column === j)}
              <div class="square {!win ? '' : win.type === humanPlayer ? 'won' : 'lost'}"
               on:click={() => move({row: i, column: j}, humanPlayer)}>

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

<button on:click={freshState}>{status.winner?.length ? 'Play again' : ' Reset'}</button>

<div class="container" style="gap: 5rem">

  <div class="container text-right" style="flex-direction: column">
    <h3>Play as</h3>
    <div>
      <label for="x">X</label>
      <input type="radio" id="x" value={Type.X} bind:group={humanPlayer}/>
    </div>
    <div>
      <label for="o">O</label>
      <input type="radio" id="o" value={Type.O} bind:group={humanPlayer}/>
    </div>
  </div>

  <div class="container text-right" style="flex-direction: column">
    <h3>AI Mode</h3>
    <div>
      <label for="dum">Dumb</label>
      <input type="radio" id="dum" value={AiMode.DUMB} bind:group={AIMode}/>
    </div>
    <div>
      <label for="minimax">Minimax</label>
      <input type="radio" id="minimax" value={AiMode.MINIMAX} bind:group={AIMode}/>
    </div>
  </div>

</div>

<style>
  .row {
    display: flex;
    gap: 3px;
  }

  .won {
    background-color: #cfe5cf !important;
  }

  .lost {
    background-color: #f8d7cd !important;
  }

  .column {
    display: flex;
    flex-direction: column;
    gap: 3px;
  }

  .state {
    padding: 1px;
    font-size: 8rem;
    color: sandybrown;
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