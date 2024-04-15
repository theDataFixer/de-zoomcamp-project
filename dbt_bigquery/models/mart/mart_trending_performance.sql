-- File: mart/trending_performance.sql
{{ config(materialized='table') }}

SELECT
    ft.trending_type,
    dt.genre_id,
    {{ stat_aggregations('ft.trending_popularity') }},
    AVG(ft.trending_vote_average) AS avg_trending_vote_average,
    SUM(ft.trending_vote_count) AS trending_total_votes,
    COUNT(*) AS content_count

FROM {{ ref('fct_trending') }} AS ft
INNER JOIN {{ ref('dim_trending_genres') }} AS dt
  ON ft._dlt_id = dt._dlt_parent_id
GROUP BY ft.trending_type, dt.genre_id
