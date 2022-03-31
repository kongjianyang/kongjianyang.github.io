---
title: Home
---


# KJY's Blog

记录具有价值，不要为过去的自己而感到羞耻

道阻且长，行则将至；行而不辍，未来可期

这个网站是自己的一个长期主义的试验田


<!-- Bioinformatics Scholar. Data Scientist. -->

<!-- ISTJer and minimalist. -->

Documents have value, don't be ashamed of yourself.

Long and difficult as the journey may be, sustained actions will take us to the destination.

This site is a praxis for my long-termism

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
    new GitHubCalendar(".calendar", "kongjianyang", { responsive: true });
</script>

可以通过utteranc给我留言。

Leave me a message by utteranc.



<details>
<summary>试试这里/Try here</summary>
<p>KJY means Kongjian Yang</p>
<p>Just start coding for interest</p>
</details>


<!-- Prepare a container for your calendar. -->
<script
  src="https://unpkg.com/github-calendar@latest/dist/github-calendar.min.js"
></script>

<!-- Optionally, include the theme (if you don't want to struggle to write the CSS) -->
<link
  rel="stylesheet"
  href="https://unpkg.com/github-calendar@latest/dist/github-calendar-responsive.css"
/>

<!-- Prepare a container for your calendar. -->
<div class="calendar">
    <!-- Loading stuff -->
    aaaaaa
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
