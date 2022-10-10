<script lang="ts">
    import {onMount} from "svelte";

    let data = {
        'S': ['200', '406'],
        '200': ['201', '301', '1309'],
        '301': ['305', '201'],
        '201': ['F', '1309'],
        '305': ['301'],
        '1309': [],
        'F': [],
        '406': []
    } as Record<string, string[]>

    let start = 'S'
    let journey = [start]

    function nextInJourney() {
        if (data[journey[journey.length - 1]].length > 0) {
            journey.push(data[journey[journey.length - 1]][0])
        } else {
            let koht = journey.length - 1
            journey.pop()
        }
    }


    onMount(() => {
        nextInJourney()
        nextInJourney()
        console.log(journey)
        nextInJourney()
        console.log(journey)
    })
</script>

<div class="board" style="margin-bottom: 5px">
    Nothing
</div>
