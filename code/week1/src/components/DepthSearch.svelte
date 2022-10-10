<script lang="ts">
  import {onMount} from "svelte";

  let data = {
    'S': ['200', '406'],
    '200': ['201', '301', '1309'],
    '300': ['201'],
    '301': ['201'],
    '201': ['F'],
  } as Record<string, string[]>

  function search(data, entrypoint) {
    data[entrypoint].forEach(d => {
      if (d === 'F') return console.log('Found Finish')
      if (data[d]) search(data, d)
    })
  }

  let best: { trail: string; points: number } = {
    points: 0,
    trail: undefined
  }
  let journey = ['S']
  function evaluate() {
    let last = journey[journey.length - 1]
    if (!data[last]?.length) return
    for (let i = 0; i < data[last].length; i++) {
      journey.push(data[last][i])
      console.log(journey.join(' - '))
      if (data[last][i] === 'F') {
        if (points() > best.points) {
          best = {
            points: points(), trail: journey.join(' - ')
          }
        }
      }
      evaluate()
      journey.pop()
    }
  }

  function points() {
    let sum = 0
    for (let i = 0; i < journey.length; i++) {
      if (journey[i].length > 2) sum += parseInt(String(journey[i] / 100))
    }
    return sum
  }

  onMount(() => {
    let finish = []
    // search(data, 'S')

    evaluate()
    console.log('points', best)
  })
</script>

<div class="board" style="margin-bottom: 5px">
  <p>{best?.points}</p>
  <p>{best?.trail}</p>
</div>
