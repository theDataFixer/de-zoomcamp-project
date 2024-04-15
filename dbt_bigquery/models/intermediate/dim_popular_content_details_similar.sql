-- File: intermediate/dim_popular_content_details_similar.sql
{{ config(materialized='table') }}

WITH similar_movies AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_similar_sk,
      _dlt_parent_id,
      movie_similar_id AS content_similar_id,
      movie_similar_overview AS content_similar_overview,
      movie_similar_release_date AS content_similar_release_date,
      movie_similar_title AS content_similar_title
    FROM {{ ref('stg_movie_details__similar__results') }}
),

similar_tv_series AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_similar_sk,
      _dlt_parent_id,
      tv_series_similar_id AS content_similar_id,
      tv_series_similar_overview AS content_similar_overview,
      tv_series_similar_first_air_date AS content_similar_release_date,
      tv_series_similar_name AS content_similar_title
    FROM {{ ref('stg_tv_series_details__similar__results') }}
)

SELECT * FROM similar_movies
UNION ALL
SELECT * FROM similar_tv_series
