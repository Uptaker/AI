<script lang="ts">
    let state = initState()

    const isX = (value: string) => (value.toLowerCase() == 'x')

    function initState(): string[][] {
        let startingState = [[], [], [], [], [], [], [], []]
        for (let i = 0; i < 8; i++) {
            for (let j = 0; j < 8; j++) {
                if (i < 3) startingState[i][j] = (j % 2 == 0) ? (i %  2 == 0) ? 'n' : 'X' : (i %  2 == 1) ? 'n' : 'X'
                else if (i > 4) startingState[i][j] = (j % 2 == 0) ? (i %  2 == 0) ? 'N' : 'x' : (i %  2 == 1) ? 'N' : 'x'
                else startingState[i][j] = (j % 2 == 0) ? (i %  2 == 0) ? 'n' : 'x' : (i %  2 == 1) ? 'n' : 'x'
            }
        }
        return startingState
    }

</script>
<div style="width: min-content; margin: 0 auto; background-color: #BB9457">
    {#if state}
        <div style="display: flex; gap: 1px;">
            {#each state as row}
                <div style="display: flex; flex-direction: column; gap: 1px;">
                    {#each row as value}
                        <div style="width: 50px; height: 50px; display: flex; justify-content: center; align-items: center; background-color: {isX(value) ? '#99582A' : '#FFE6A7'}">
                            {#if value === 'X' || value === 'N'}
                                <div style="padding: 1px;border-radius: 50%; height: 70%; width: 70% ;background-color: {isX(value) ? '#432818' : '#6F1D1B'}"></div>
                            {/if}
                        </div>
                    {/each}
                </div>
            {/each}
        </div>
    {/if}
</div>
