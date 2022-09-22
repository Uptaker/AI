<script lang="ts">
  let gameLength = 5
  let startState = [2, 'X']
  let text = '_ X _ _ _'


  function isAllowed(state) {
    return state[0] <= gameLength
  }

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

  function evaluateState(state) {
    if (state[0] == gameLength) {
      if (state[1] == 'N') {
        return 1
      }
      if (state[1] == 'X') {
        return -1
      }
    }
    let hinnangud = findTurns(state).map(evaluateState)
    return (state[1] == 'X') ?
      Math.max(...hinnangud) : Math.min(...hinnangud)
  }

  //Loo nupp, millele vajutades kuvatakse arvuti võimalikud käigud
  //ja iga käigu hinnang

  function stateAsText(seis) {
    let v = []
    for (let i = 0; i < gameLength; i++) {
      v.push('_')
    }
    v[seis[0] - 1] = seis[1]
    return v.join(' ')
  }

  function algus() {
    // console.log(leiaKaigud(algseis));
    // console.log(seisTekstina(algseis));
    // console.log(seisuHinnang(algseis));
    text = stateAsText(startState)
  }

  function findOpposite(kes) {
    return (kes == 'X') ? 'N' : 'X'
  }

  function inimeneKaib(mitu) {
    if (startState[0] + mitu <= gameLength) {
      startState[0] += mitu
      if (startState[0] == gameLength) {
        alert('Võitis ' + startState[1])
      }
      startState[1] = findOpposite(startState[1])
      text = stateAsText(startState)
    } else {
      alert('üle ääre')
    }
  }

  //Lõppu jõudmisel teata, kelle võit oli
  function moveComputer() {
    let k = findTurns(startState)
    if (k.length > 0) {
      startState = k[parseInt(Math.random() * k.length)]
      if (startState[0] == gameLength) {
        alert('Võitis ' + findOpposite(startState[1]))
      }
      text = stateAsText(startState)
    } else {
      alert('Pole käike')
    }
  }

  function moveComputerWithEvaluation() {
    let k = findTurns(startState)
    for (let i = 0; i < k.length; i++) {
      console.log(k[i], evaluateState(k[i]))
    }
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

<div>{text}</div>
<input type="button" value="1" on:click={() => inimeneKaib(1)}/>
<input type="button" value="2" on:click={() => inimeneKaib(2)}/>
<input type="button" value="a" on:click={moveComputer}/>
<input type="button" value="av" on:click={moveComputerWithEvaluation}/>
<input type="button" value="ap" on:click={movePcBest}/>




