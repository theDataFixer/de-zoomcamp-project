-- File: mart/trending_genre_distribution.sql
{{ config(materialized='table') }}

SELECT
    ft.trending_type,
    dt.genre_id,
    COUNT(DISTINCT ft.trending_id) AS content_count

FROM {{ ref('fct_trending') }} AS ft
INNER JOIN {{ ref('dim_trending_genres') }} AS dt
    ON ft._dlt_id = dt._dlt_parent_id
GROUP BY ft.trending_type, dt.genre_id
