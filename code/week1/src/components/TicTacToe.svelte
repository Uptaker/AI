<script lang="ts">

    import {onMount} from "svelte";

    enum Type {
        X = 'X', O = 'O', BLANK = ''
    }

    type State = Type.X | Type.O | Type.BLANK

    let states: State[][] = freshState()

    onMount(() => console.log(states))

    function freshState() {
        return [[Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK], [Type.BLANK, Type.BLANK, Type.BLANK]]
    }

</script>

<div class="board" style="margin-bottom: 5px">
    {#if states}
        <div class="column">
            {#each states as row, i}
                <div class="row">
                    {#each row as value, j}
                        <div class="square">
                            {#if value !== Type.BLANK}
                                <div class="state">{value}</div>
                            {/if}
                        </div>
                    {/each}
                </div>
            {/each}
        </div>
    {/if}
</div>

<button>End game</button>


<style>
    .row {
        display: flex;
        gap: 3px;
    }

    .column {
        display: flex;
        flex-direction: column;
        gap: 3px;
    }

    .state {
        padding: 1px;
        border-radius: 50%;
        height: 70%;
        width: 70%;
    }

    .state:hover {
        opacity: 50%;
    }

    .square {
        width: 150px;
        height: 150px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: antiquewhite;
    }

    .board {
        width: min-content;
        margin: 0 auto;
    }
</style>