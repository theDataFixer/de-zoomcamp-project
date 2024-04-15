-- File: intermediate/fct_trending.sql
{{ config(materialized='table') }}

WITH trending_content AS (
    SELECT
        _dlt_id,
        trending_movie_id AS trending_id,
        'Movie' AS trending_type,
        trending_movie_popularity AS trending_popularity,
        trending_movie_vote_average AS trending_vote_average,
        trending_movie_vote_count AS trending_vote_count
    FROM {{ ref('stg_trending_movies') }}
    UNION ALL
    SELECT
        _dlt_id,
        trending_tv_series_id AS trending_id,
        'TV Series' AS trending_type,
        trending_tv_series_popularity AS trending_popularity,
        trending_tv_series_vote_average AS trending_vote_average,
        trending_tv_series_vote_count AS trending_vote_count
    FROM {{ ref('stg_trending_tv_series') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['_dlt_id']) }} AS fct_trending_sk,
    _dlt_id,
    trending_id,
    trending_type,
    trending_popularity,
    trending_vote_average,
    trending_vote_count
FROM trending_content
