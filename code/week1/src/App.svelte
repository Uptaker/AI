<script lang="ts">

  import {slide} from 'svelte/transition'
  import TeacherSolution from "./components/TeacherSolution.svelte";
  import UnfinishedSolution from "./components/UnfinishedSolution.svelte";
  import TeacherSomething from "./components/WithBuffer.svelte";
  import Rida6 from "./components/Rida6.svelte";
  import Checkers from "./components/Checkers.svelte";
  import {SvelteComponent} from "svelte";

  let component = Checkers

  const switchTo = (comp: SvelteComponent) => component = comp

</script>
<div style="margin-bottom: 100px">
  <button on:click={() => switchTo(UnfinishedSolution)}>Unfinished</button>
  <button on:click={() => switchTo(TeacherSolution)}>Teacher's</button>
  <button on:click={() => switchTo(TeacherSomething)}>With buffer</button>
  <button on:click={() => switchTo(Rida6)}>Rida6</button>
  <button on:click={() => switchTo(Checkers)}>Checkers</button>
</div>
<br>

<svelte:component this={component}></svelte:component>
