-- File: intermediate/dim_trending_genres.sql
{{ config(materialized='table') }}

WITH combined_genre_trending AS (
    SELECT
        _dlt_parent_id,
        trending_movie_genre_id_value AS genre_id
    FROM {{ ref('stg_trending_movies__genre_ids') }}
    UNION ALL
    SELECT
        _dlt_parent_id,
        trending_tv_series_genre_id_value AS genre_id
    FROM {{ ref('stg_trending_tv_series__genre_ids') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_trending_genres_sk,
    _dlt_parent_id,
    genre_id
FROM combined_genre_trending
