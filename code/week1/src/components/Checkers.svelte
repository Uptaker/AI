<script lang="ts">

    import {onMount} from "svelte";

    let startState = [[], [], [], [], [], [], [], []]

    onMount(() => {
        init()

        for (let i = 0; i < startState.length; i++) {
            console.log(startState[i].join(" "))
        }
            })
    function init() {
        for (let i = 0; i < 8; i++) {
            for (let j = 0; j < 8; j++) {
                if (i == 0) startState[i][j] = 'X'
                else if (i == 7) startState[i][j] = 'N'
                else startState[i][j] = (j % 2 == 0) ? 'n' : 'x'
            }
        }
    }

</script>