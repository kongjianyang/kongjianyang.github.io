---
title: Home
---





Bioinformatics Scholar. Data Scientist.

ISTJer and minimalist

道阻且长，行则将至；行而不辍，未来可期

Long and difficult as the journey may be, sustained actions will take us to the destination.

不要为过去的自己而感到羞耻，记录就是过去的自己

这是自己的一个长期主义的试验田


<!--more-->

<!-- Prepare a container for your calendar. -->
<script
  src="https://cdn.rawgit.com/IonicaBizau/github-calendar/gh-pages/dist/github-calendar.min.js"
>
</script>

<!-- Optionally, include the theme (if you don't want to struggle to write the CSS) -->
<link
  rel="stylesheet"
  href="https://cdn.rawgit.com/IonicaBizau/github-calendar/gh-pages/dist/github-calendar.css"
/>

<!-- Prepare a container for your calendar. -->
<div class="calendar">
    <!-- Loading stuff -->
    Loading the data just for you.
</div>

<script>
    new GitHubCalendar(".calendar", "kongjianyang");
</script>
<!-- Prepare a container for your calendar. -->


<img src="https://ghchart.rshah.org/kongjianyang" alt="KJY's Github chart" />


I wrote a JavaScript library to do that: github-calendar.

Here is an example how to use it:

<!-- Prepare a container for your calendar. -->
<script
  src="https://cdn.rawgit.com/IonicaBizau/github-calendar/gh-pages/dist/github-calendar.min.js"
>
</script>

<!-- Optionally, include the theme (if you don't want to struggle to write the CSS) -->
<link
  rel="stylesheet"
  href="https://cdn.rawgit.com/IonicaBizau/github-calendar/gh-pages/dist/github-calendar.css"
/>

<!-- Prepare a container for your calendar. -->
<div class="calendar">
    <!-- Loading stuff -->
    Loading the data just for you.
</div>

<script>
    new GitHubCalendar(".calendar", "kongjianyang");
</script>




### 新的测试

<!-- Include the library. -->
<script
  src="https://unpkg.com/github-calendar@latest/dist/github-calendar.min.js">
</script>

<!-- Optionally, include the theme (if you don't want to struggle to write the CSS) -->
<link
  rel="stylesheet"
  href="https://unpkg.com/github-calendar@latest/dist/github-calendar-responsive.css"
/>

<!-- Prepare a container for your calendar. -->
<div class="calendar">
    <!-- Loading stuff -->
    Loading the data just for you.
</div>

<script>
    GitHubCalendar(".calendar", "kongjianyang");

    // or enable responsive functionality:
    GitHubCalendar(".calendar", "kongjianyang", { responsive: true });

    // Use a proxy
    GitHubCalendar(".calendar", "kongjianyang", {
       proxy (username) {
         return fetch(`https://your-proxy.com/github?user=${username}`)
       }
    }).then(r => r.text())
</script>