<script lang="ts">

  import {onMount} from 'svelte'

  enum Type {
    X = 'X', O = 'O', BLANK = ''
  }

  let humanPlayer = Type.X
  let AIPlayer = Type.O

  const winCombos = [
    [[0, 0], [0, 1], [0, 2]],
    [[1, 0], [1, 1], [1, 2]],
    [[2, 0], [2, 1], [2, 2]],
    [[0, 0], [1, 0], [2, 0]],
    [[0, 1], [1, 1], [2, 1]],
    [[0, 2], [1, 2], [2, 2]],
    [[0, 0], [1, 1], [2, 2]],
    [[2, 2], [1, 1], [0, 0]],
  ]

  type State = Type.X | Type.O | Type.BLANK

  let states: State[][]

  onMount(() => {
    freshState()
    console.log(states)
  })

  function freshState() {
    states = [[Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK]]
  }

  function movePlayer(row: number, column: number) {
    if (states[row][column] !== Type.BLANK) return
    states[row][column] = humanPlayer
  }

</script>

<div class="board" style="margin-bottom: 5px">
  {#if states}
    <div class="column">
      {#each states as row, i}
        <div class="row">
          {#each row as value, j}
            <div class="square" on:click={() => movePlayer(i, j)}>
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

<button on:click={freshState}>End game</button>


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