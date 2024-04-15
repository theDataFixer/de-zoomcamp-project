-- File: mart/granular_trending_content.sql
{{ config(materialized='table') }}

SELECT
    ft.trending_id,
    ft.trending_type,
    ft.trending_popularity,
    ft.trending_vote_average,
    ft.trending_vote_count,
    ti.trending_title,
    ti.trending_original_language,
    ti.trending_overview,
    ti.trending_release_date,
    tg.genre_name

FROM {{ ref('fct_trending') }} AS ft
LEFT JOIN {{ ref('dim_trending_info') }} AS ti
    ON ft._dlt_id = ti._dlt_id
LEFT JOIN {{ ref('dim_trending_genres') }} AS dtg
    ON ft._dlt_id = dtg._dlt_parent_id
LEFT JOIN {{ ref('dim_genres') }} AS tg
    ON dtg.genre_id = tg.genre_id
