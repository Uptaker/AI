<script lang="ts">
  let gameLength = 41
  let startState = [5, 'X']
  let text = stateAsText(startState)

  const isAllowed = (state) => state[0] <= gameLength

  function findTurns(state) {
    let opposite = findOpposite(state[1])
    let answer = []
    let newState = [state[0] + 1, opposite]
    if (isAllowed(newState)) {
      answer.push(newState)
    }
    newState = [state[0] + 2, opposite]
    if (isAllowed(newState)) {
      answer.push(newState)
    }
    return answer
  }

  function evaluateState(states) {
    if (states[0] == gameLength) {
      if (states[1] == 'N') return 1
      if (states[1] == 'X') return -1
    }
    let turns = findTurns(states)
    let evaluations = []
    for (let i = 0; i < turns.length; i++) {
      let evaluation = evaluateState(turns[i])
      if (states[1] == 'X' && evaluation == 1) return evaluation // optimizations
      if (states[1] == 'N' && evaluation == -1) return evaluation
      evaluations.push(evaluation)
    }
    return (states[1] == 'X') ? Math.max(...evaluations) : Math.min(...evaluations)
  }

  function stateAsText(state) {
    let v = []
    for (let i = 0; i < gameLength; i++) {
      v.push('_')
    }
    v[state[0] - 1] = state[1]
    return v.join(' ')
  }

  function findOpposite(kes) {
    return (kes == 'X') ? 'N' : 'X'
  }

  //Loo nupp arvutiga parima käigu käimiseks
  function movePcBest() {
    let k = findTurns(startState)
    let hinnangud = k.map(evaluateState)
    let mitmes = 0
    let parimHinnang = (startState[1] == 'X') ?
      Math.max(...hinnangud) : Math.min(...hinnangud)
    for (let i = 0; i < k.length; i++) {
      if (hinnangud[i] == parimHinnang) {
        mitmes = i
      }
    }
    startState = k[mitmes]
    text = stateAsText(startState)
  }
</script>

<div style="margin-bottom: 30px">{text}</div>
<button on:click={movePcBest}>Move PC</button>