{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'tv_series_details__similar__results') }}
)

SELECT
    id AS tv_series_similar_id,
    original_language AS tv_series_similar_original_language,
    overview AS tv_series_similar_overview,
    popularity AS tv_series_similar_popularity,
    first_air_date AS tv_series_similar_first_air_date,
    name AS tv_series_similar_name,
    vote_average AS tv_series_similar_vote_average,
    vote_count AS tv_series_similar_vote_count,
    _dlt_parent_id,
    _dlt_id

    {#- Unused columns:
    - adult
    - backdrop_path
    - original_name
    - poster_path
    - _dlt_list_idx
    #}

FROM source
