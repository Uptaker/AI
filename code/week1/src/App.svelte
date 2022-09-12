<script lang="ts">

  import TeacherSolution from "./components/TeacherSolution.svelte";
  import UnfinishedSolution from "./components/UnfinishedSolution.svelte";
  import TeacherSomething from "./components/WithBuffer.svelte";
  import Rida6 from "./components/Rida6.svelte";
  import Checkers from "./components/Checkers.svelte";

  let component = Checkers
</script>
<div style="margin-bottom: 100px">
  <button on:click={() => component = UnfinishedSolution}>Unfinished</button>
  <button on:click={() => component = TeacherSolution}>Teacher's</button>
  <button on:click={() => component = TeacherSomething}>With buffer</button>
  <button on:click={() => component = Rida6}>Rida6</button>
  <button on:click={() => component = Checkers}>Checkers</button>
</div>
<br>

<svelte:component this={component}/>