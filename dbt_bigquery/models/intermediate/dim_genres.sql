-- File: intermediate/dim_genres.sql
{{ config(materialized='table') }}

WITH genres AS (
    SELECT
        _dlt_id,
        'Movie' AS genre_type,
        genre_movie_id AS genre_id,
        genre_movie_name AS genre_name
    FROM {{ ref('stg_genres_movie') }}
    UNION DISTINCT
    SELECT
        _dlt_id,
        'TV Series' AS genre_type,
        genre_tv_series_id AS genre_id,
        genre_tv_series_name AS genre_name
    FROM {{ ref('stg_genres_tv_series') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['_dlt_id']) }} AS dim_genres_sk,
    _dlt_id,
    genre_type,
    genre_id,
    genre_name
FROM genres
