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

<div class="board">
    {#if state}
        <div class="row">
            {#each state as row}
                <div class="column">
                    {#each row as value}
                        <div class="square" style="background-color: {isX(value) ? '#99582A' : '#FFE6A7'}">
                            {#if value === 'X' || value === 'N'}
                                <div class="checker" style="background-color: {isX(value) ? '#432818' : '#BB9457'}"></div>
                            {/if}
                        </div>
                    {/each}
                </div>
            {/each}
        </div>
    {/if}
</div>

<style>
    .row {
        display: flex;
    }

    .column {
        display: flex;
        flex-direction: column;
    }

    .checker {
        padding: 1px;
        border-radius: 50%;
        height: 70%;
        width: 70%;
    }

    .square {
        width: 50px;
        height: 50px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .board {
        width: min-content;
        margin: 0 auto;
    }
</style>
