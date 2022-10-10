<script lang="ts">

  import TeacherSolution from './components/TeacherSolution.svelte'
  import UnfinishedSolution from './components/UnfinishedSolution.svelte'
  import TeacherSomething from './components/WithBuffer.svelte'
  import Rida6 from './components/Rida6.svelte'
  import Checkers from './components/Checkers.svelte'
  import {SvelteComponent} from 'svelte'
  import CheckersJaagup from './components/CheckersJaagup.svelte'
  import TicTacToe from './components/TicTacToe.svelte'
  import Teekond from "./components/Teekond.svelte";
  import Bloxors from "./components/Bloxors.svelte";
  import DepthSearch from "./components/DepthSearch.svelte";
  import DepthSearchFixed from "./components/DepthSearchFixed.svelte";
  import DepthSearchNoRecursion from "./components/DepthSearchNoRecursion.svelte";

  let component = DepthSearchNoRecursion

  const switchTo = (comp: SvelteComponent) => component = comp

</script>
<div style="margin-bottom: 100px">
  <button on:click={() => switchTo(UnfinishedSolution)}>Unfinished</button>
  <button on:click={() => switchTo(TeacherSolution)}>Teacher's</button>
  <button on:click={() => switchTo(TeacherSomething)}>With buffer</button>
  <button on:click={() => switchTo(Rida6)}>Rida6</button>
  <button on:click={() => switchTo(CheckersJaagup)}>Checkers (with string)</button>
  <button on:click={() => switchTo(Checkers)}>Checkers</button>
  <button on:click={() => switchTo(TicTacToe)}>Tic-Tac-Toe</button>
  <button on:click={() => switchTo(Teekond)}>Teekond</button>
  <button on:click={() => switchTo(Bloxors)}>Bloxorz</button>
  <button on:click={() => switchTo(DepthSearch)}>Depth Search (cant allow cycles)</button>
  <button on:click={() => switchTo(DepthSearchFixed)}>Depth Search (fixed)</button>
  <button on:click={() => switchTo(DepthSearchNoRecursion)}>Depth Search (no recursion)</button>

</div>
<svelte:component this={component}/>
