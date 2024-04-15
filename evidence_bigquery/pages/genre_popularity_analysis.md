---
title: Genre Popularity Analysis
---

Identify which genres are the most popular among movies and TV series.

```sql sql_query_merge_genre
SELECT
    dim.genre_name AS content_genre_name,
    trd.trending_type AS content_type,
    trd.content_count
FROM trending_genre trd   
LEFT JOIN dim_genres dim
    ON trd.genre_id = dim.genre_id
```


```sql sql_query_genre
SELECT DISTINCT
    content_genre_name,
    content_type,
    SUM(content_count) AS content_count
FROM
    (
        SELECT
            content_type,
            content_genre_name,
            content_count
        FROM popular_genre
        UNION ALL
        SELECT *
        FROM ${sql_query_merge_genre}
    ) AS combined_genre
WHERE 1=1
    AND content_count > 0
    AND content_genre_name NOT IN ('Movie', 'TV Series')
GROUP BY
    content_genre_name, content_type
ORDER BY
    content_genre_name, content_type
```

<BarChart
    data={sql_query_genre}
    x=content_genre_name
    y=content_count
    series=content_type
    swapXY=true
    sort=true
    colorPalette={
        [
    '#E6194B',
    '#3CB44B',
    '#FFE119',
    '#4363D8',
    '#F58231', 
    '#911EB4',
    '#46F0F0',
    '#F032E6',
    '#BCF60C',
    '#FABEBE', 
    '#008080',
    '#E6BEFF',
    '#9A6324',
    '#FFFAC8',
    '#800000', 
    '#AAFFC3',
    '#808000',
    '#FFD8B1',
    '#000075',
    '#808080'
        ]    
    }
/>

