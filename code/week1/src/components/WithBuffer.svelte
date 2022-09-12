<script lang="ts">
    import {onMount} from 'svelte'

    let gameLength = 47 // can change
    let startState = [11, 'N']
    let buffer = [[gameLength, 'X', -1], [gameLength, 'N', 1]]
    let place = gameLength - 3

    const opposite = (who: string) => (who == 'X') ? 'N' : 'X'

    onMount(() => {
        while (place >= startState[0]) {

            // lisa eelmise põhjal võidust ÜHE käigu kaugusel hinnangud
            buffer.push([gameLength - 1, 'X', 1])
            buffer.push([gameLength - 1, 'N', -1])

            // lisa eelmise põhjal võidust KAHE käigu kaugusel hinnangud
            buffer.push([gameLength - 2, 'X', 1])
            buffer.push([gameLength - 2, 'N', -1])

            buffer.push([place, 'X', Math.max(
                buffer[buffer.length - 1][2] as number,
                buffer[buffer.length - 3][2] as number
            )])

            buffer.push([place, 'N', Math.max(
                buffer[buffer.length - 3][2] as number,
                buffer[buffer.length - 5][2] as number
            )])
            place--
            buffer.shift().shift()
        }
        console.log('buffer', buffer)

        // Puhvri järgi kuva algseisule vastav soovitav käik
        let turns = []

        for(let i = 3; i <= 6; i++) {
            if (buffer[buffer.length - i][1] == startState[1]) continue
            console.log(buffer[buffer.length - i])
            turns.push(buffer[buffer.length - i])
        }
        turns.sort((turn1, turn2) => turn1[2] - turn2[2])
        console.log(turns)

        if (startState[1] == 'X') console.log("Best", turns[turns.length - 1])
        else console.log("Worst", turns[0])
    })
</script>


<p>Console -></p>