-- File: intermediate/dim_popular_content_details_info.sql
{{ config(materialized='table') }}

WITH movies AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['_dlt_id']) }} AS dim_popular_content_details_info_sk,
        _dlt_id,
        'Movie' AS content_type,
        movie_id AS content_id,
        movie_original_language AS content_original_language,
        movie_overview AS content_overview,
        SAFE.PARSE_DATE('%Y-%m-%d', movie_release_date) AS content_release_date,
        movie_status AS content_status,
        movie_title AS content_title
    FROM {{ ref('stg_movie_details') }}
),

tv_series AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['_dlt_id']) }} AS dim_popular_content_details_info_sk,
        _dlt_id,
        'TV Series' AS content_type,
        tv_series_id AS content_id,
        tv_series_original_language AS content_original_language,
        tv_series_overview AS content_overview,
        SAFE.PARSE_DATE('%Y-%m-%d', tv_series_first_air_date) AS content_release_date,
        tv_series_status AS content_status,
        tv_series_name AS content_title
    FROM {{ ref('stg_tv_series_details') }}
)

SELECT * FROM movies
UNION ALL
SELECT * FROM tv_series
