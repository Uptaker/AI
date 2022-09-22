<script lang="ts">
  //x maksimeerija
  //n minimeerija

  interface GameState {
    position: number,
    label: 'x' | 'n'
  }


  const gameLength = 7
  let count = 0
  let state: GameState = {position: 3, label: 'x'}
  let winner: 'PC' | 'Human'


  const allowedToMove = (state: GameState) => state.position < gameLength

  const findLabel = (label: string) => (label == 'x') ? 'n' : 'x'

  function movePlayer() {
    if (state.label == 'n') state.position += 2
    else state.position++
    state.label = findLabel(state.label)
    count++
    if (!canMove) winner = 'Human'
  }

  function findTurns(state: GameState): GameState[] {
    const opposite = findLabel(state.label)
    let states = []
    let newState: GameState = {position: state.position + 1, label: opposite}
    if (allowedToMove(newState)) states.push(newState)
    newState = {position: state.position + 2, label: opposite}
    if (allowedToMove(newState)) states.push(newState)
    return states
  }

  function decide(state: GameState) {
    if (state.position == gameLength) return (state.label == 'n') ? 1 : 2
    let turns = findTurns(state)
    let estimations = []
    turns.forEach((turn) => estimations.push(decide(turn)))
    return (state.label == 'x') ? Math.max(...estimations) : Math.min(...estimations)
  }

  function movePC() {
    (Math.random() >= 0.5 || (state.position + 1) == gameLength) ? state.position++ : state.position += 2
    state.label = findLabel(state.label)
    count++
    if (!canMove) winner = 'PC'
  }

  function movePCBetter() {
    let turns = findTurns(state)
    let estimations = turns.map(decide)
    let count = 0
    let bestEstimate = (state.label == 'x') ? Math.max(...estimations) : Math.min(...estimations)
    for (let i = 0; i < turns.length; i++) {
      if (estimations[i] == bestEstimate) count = 1
    }
    state.position += estimations[count]
  }

  function reset() {
    state = {position: 3, label: 'x'}
    count = 0
  }

  $: canMove = allowedToMove(state)
</script>

<main>
  <!--  <h1>{!canMove ? `${winner} won!` : count}</h1>-->

  <div class="play-area">
    {#each Array(gameLength) as _, i}
      <div class="line" class:active={(i + 1) === state.position}>{(i + 1) === state.position ? state.label : ''}</div>
    {/each}
  </div>

  <button disabled={!canMove} on:click={movePlayer}>Move me</button>
  <button disabled={!canMove} on:click={movePC}>Move PC</button>
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
        margin: 5rem auto;
        display: flex;
        justify-content: center;
        gap: 20px;
    }

    .active {
        background-color: blue;
    }
</style>