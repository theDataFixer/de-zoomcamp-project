-- File: intermediate/dim_trending_info.sql
{{ config(materialized='table') }}

WITH trending_info AS (
    SELECT
        _dlt_id,
        'Movie' AS trending_type,
        trending_movie_title AS trending_title,
        trending_movie_original_language AS trending_original_language,
        trending_movie_overview AS trending_overview,
        SAFE.PARSE_DATE('%Y-%m-%d', trending_movie_release_date) AS trending_release_date,
    FROM {{ ref('stg_trending_movies') }}
    UNION ALL
    SELECT
        _dlt_id,
        'TV Series' AS trending_type,
        trending_tv_series_name AS trending_title,
        trending_tv_series_original_language AS trending_original_language,
        trending_tv_series_overview AS trending_overview,
        SAFE.PARSE_DATE('%Y-%m-%d', trending_tv_series_first_air_date) AS trending_release_date,
    FROM {{ ref('stg_trending_tv_series') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['_dlt_id']) }} AS dim_trending_info_sk,
    _dlt_id,
    trending_type,
    trending_title,
    trending_original_language,
    trending_overview,
    trending_release_date
FROM trending_info
