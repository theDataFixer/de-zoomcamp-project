{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'trending_movies') }}
)

SELECT
    id AS trending_movie_id,
    title AS trending_movie_title,
    original_language AS trending_movie_original_language,
    overview AS trending_movie_overview,
    popularity AS trending_movie_popularity,
    release_date AS trending_movie_release_date,
    vote_average AS trending_movie_vote_average,
    vote_count AS trending_movie_vote_count,
    _dlt_id


    {#- Unused columns:
    - adult
    - backdrop_path
    - original_title
    - poster_path
    - media_type
    - video
    - _dlt_load_id
    #}

FROM source
