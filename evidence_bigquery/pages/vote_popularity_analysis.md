---
title: Vote Popularity Analysis
---

Understand how different genres are rated by viewers

```sql sql_query_merge_genre
SELECT
    dim.genre_name,
    trd.avg_ft_trending_popularity AS avg_content_popularity,
    trd.trending_total_votes AS total_votes
FROM trending_performance trd
LEFT JOIN dim_genres dim
    ON trd.genre_id = dim.genre_id
```

```sql sql_query_vote
SELECT
    genre_name,
    AVG(avg_content_popularity) AS avg_content_popularity,
    AVG(total_votes) AS avg_total_votes
FROM
    (
        SELECT
            content_genre_name AS genre_name,
            avg_fp_content_popularity AS avg_content_popularity,
            total_votes
        FROM popular_performance
        UNION ALL
        SELECT *
        FROM ${sql_query_merge_genre}
    ) AS combined_performance
GROUP BY
    genre_name
ORDER BY
    genre_name
```

<ScatterPlot
    data={sql_query_vote}
    x=avg_content_popularity
    y=avg_total_votes
    series=genre_name
/>
