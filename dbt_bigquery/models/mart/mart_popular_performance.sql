-- File: mart/popular_content_performance.sql
{{ config(materialized='table') }}

SELECT
    fp.content_type,
    dpg.content_genre_name,
    {{ stat_aggregations('fp.content_popularity') }},
    AVG(fp.content_vote_average) AS avg_vote_average,
    SUM(fp.content_vote_count) AS total_votes,
    COUNT(*) AS content_count

FROM {{ ref('fct_popular_content_details') }} AS fp
INNER JOIN {{ ref('dim_popular_content_details_genres') }} AS dpg
  ON fp._dlt_id = dpg._dlt_parent_id
GROUP BY fp.content_type, dpg.content_genre_name
