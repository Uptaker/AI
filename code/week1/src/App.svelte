<script lang="ts">
  //x maksimeerija
  //n minimeerija

  interface GameState {
    position: number,
    label: 'x' | 'n'
  }

  let count = 0
  let gameLength = 7
  let state: GameState = {position: 3, label: 'x'}
  let winner: 'PC' | 'Human'

  $: canMove = state.position >= gameLength

  const findLabel = (label: string) => (label == 'x') ? 'n' : 'x'

  function movePlayer() {
    if (state.label == 'n') state.position+= 2
    else state.position++
    state.label = findLabel(state.label)
    count++
    if (!canMove) winner = 'Human'
  }
  function movePC() {
    (Math.random() >= 0.5 || (state.position + 1) == gameLength) ? state.position++ : state.position+= 2
    state.label = findLabel(state.label)
    count++
    if (!canMove) winner = 'PC'
  }

  function reset() {
    state = {position: 3, label: 'x'}
    count = 0
  }
</script>

<main>
  <h1>{canMove ? `${winner} won!` : count}</h1>

  <div class="play-area">
    {#each Array(gameLength) as _, i}
      <div class="line" class:active={(i + 1) === state.position}>{(i + 1) === state.position ? state.label : ''}</div>
    {/each}
  </div>

  <button disabled={canMove} on:click={movePlayer}>Move me</button>
  <button disabled={canMove} on:click={movePC}>Move PC</button>
  <button on:click={reset}>Reset</button>

  <div>
    <span>Position: <b>{state.position}</b></span>
    <span>Label: <b>{state.label}</b></span>
  </div>
</main>

<style>
  .line {
    width: 50px;
    height: 5px;
    background-color: red;
  }

  .play-area {
    margin: 5rem 0;
    display: flex;
    gap: 20px;
  }

  .active {
    background-color: blue;
  }
</style>
