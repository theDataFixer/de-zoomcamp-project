{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'movie_details__similar__results') }}
)

SELECT
    id AS movie_similar_id,
    original_language AS movie_similar_original_language,
    overview AS movie_similar_overview,
    popularity AS movie_similar_popularity,
    release_date AS movie_similar_release_date,
    title AS movie_similar_title,
    vote_average AS movie_similar_vote_average,
    vote_count AS movie_similar_vote_count,
    _dlt_parent_id,
    _dlt_id

    {#- Unused columns:
    - adult
    - backdrop_path
    - original_title
    - poster_path
    - video
    - _dlt_list_idx
    #}

FROM source
