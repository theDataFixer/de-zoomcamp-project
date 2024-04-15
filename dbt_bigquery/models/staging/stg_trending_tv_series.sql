{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'trending_tv_series') }}
)

SELECT
    id AS trending_tv_series_id,
    name AS trending_tv_series_name,
    original_language AS trending_tv_series_original_language,
    overview AS trending_tv_series_overview,
    popularity AS trending_tv_series_popularity,
    first_air_date AS trending_tv_series_first_air_date,
    vote_average AS trending_tv_series_vote_average,
    vote_count AS trending_tv_series_vote_count,
    _dlt_id


    {#- Unused columns:
    - adult
    - backdrop_path
    - original_name
    - poster_path
    - media_type
    - _dlt_load_id
    #}

FROM source
