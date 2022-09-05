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

  function move() {
    if (state.position >= gameLength) return
    if (state.label == 'n') {
      state.position+= 2
      state.label = 'x'
    } else {
      state.position++
      state.label = 'n'
    }
    count++
  }

  function reset() {
    state = {position: 3, label: 'x'}
    count = 0
  }
</script>

<main>
  <h1>{count}</h1>

  <div class="play-area">
    {#each Array(gameLength) as _, i}
      <div class="line" class:active={(i + 1) === state.position}>{(i + 1) === state.position ? state.label : ''}</div>
    {/each}
  </div>

  <button disabled={state.position >= gameLength} on:click={move}>Move</button>
  <button on:click={reset}>Reset</button>

  <pre>{JSON.stringify(state)}</pre>
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
