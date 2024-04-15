-- File: intermediate/dim_popular_content_details_genres.sql
{{ config(materialized='table') }}

WITH movie_genres AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_genre_sk,
      movie_genre_id AS content_genre_id,
      movie_genre_name AS content_genre_name,
      _dlt_parent_id
    FROM {{ ref('stg_movie_details__genres') }}
),

tv_series_genres AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_genre_sk,
      tv_series_genre_id AS content_genre_id,
      tv_series_genre_name AS content_genre_name,
      _dlt_parent_id
    FROM {{ ref('stg_tv_series_details__genres') }}
)

SELECT * FROM movie_genres
UNION ALL
SELECT * FROM tv_series_genres
