---
title: Seasonality in Media Releases 
---

Analysis if there's a specific time of year when more movies or TV series are released.


```sql sql_query_timeline
SELECT
    release_year AS year,
    content_type,
    SUM(trending_count) AS trending_count
FROM
    (
        SELECT *
        FROM popular_timeline
        UNION ALL
        SELECT *
        FROM trending_timeline
    ) AS combined_timeline
GROUP BY
    year, content_type
ORDER BY
    year, content_type
```

<!-- <LineChart -->
<!--     data={sql_query_timeline} -->
<!--     x=year -->
<!--     y=trending_count -->
<!--     series=content_type -->
<!-- /> -->

<AreaChart
    data={sql_query_timeline}
    x=year
    y=trending_count
    series=content_type
/>
