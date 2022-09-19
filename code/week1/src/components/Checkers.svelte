<script lang="ts">
    import {onMount} from "svelte";

    let state = initState()

    onMount(() => {
        for (let i = 0; i < state.length; i++) {
            console.log(state[i].join(" "))
        }
    })

    const isX = (value: string) => (value.toLowerCase() == 'x')
    const isPlayer = (value: string) => value == 'X' || 'N'

    function initState(): string[][] {
        let startingState = [[], [], [], [], [], [], [], []]
        for (let i = 0; i < 8; i++) {
            for (let j = 0; j < 8; j++) {
                if (i < 3) startingState[i][j] = (j % 2 == 0) ? (i %  2 == 0) ? 'n' : 'X' : (i %  2 == 1) ? 'n' : 'X'
                else if (i > 4) startingState[i][j] = (j % 2 == 1) ? (i %  2 == 0) ? 'N' : 'n' : (i %  2 == 1) ? 'N' : 'n'
                else startingState[i][j] = (j % 2 == 0) ? (i %  2 == 0) ? 'n' : 'x' : (i %  2 == 1) ? 'n' : 'x'
            }
        }
        return startingState
    }

    function move(row?: number, column?: number) {
        if (row && column) {
            console.log(row, column, state[row][column])
            for (let r = row - 1; r < row + 2; r++) {
                console.log(r)
                for (let c = column - 1; c < column + 2; c++) {
                    if (isX(state[row][column]) && state[r][c] == 'x') swap(r, c, row, column)
                    else if (!isX(state[row][column]) && state[r][c] == 'x') swap(r, c, row, column)
                }
            }
        }
        console.log('move')
    }

    function color(value: string) {
           return (value == 'x' || value == 'X' || value == 'N') ? '#99582A' : '#FFE6A7'
    }

    function swap(newRow: number, newColumn: number, oldRow: number, oldColumn: number) {
         let oldValue = state[oldRow][oldColumn]
         let newValue = state[newRow][newColumn]
         state[newRow][newColumn] = oldValue
         state[oldRow][oldColumn] = newValue
        console.log('swapped')
    }
</script>

<div class="board" style="margin-bottom: 5px">
    {#if state}
        <div class="row">
            {#each state as row, i}
                <div class="column">
                    {#each row as value, j}
                        <div class="square" style="background-color: {color(value)}">
                            {#if value === 'X' || value === 'N'}
                                <div on:click={() => move(i, j)} class="checker" style="background-color: {isX(value) ? '#432818' : '#BB9457'}"></div>
                            {/if}
                        </div>
                    {/each}
                </div>
            {/each}
        </div>
    {/if}
</div>

<button on:click={move}>Move</button>

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

    .checker:hover {
        opacity: 50%;
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
