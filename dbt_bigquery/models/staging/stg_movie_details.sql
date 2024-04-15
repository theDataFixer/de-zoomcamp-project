{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'movie_details') }}
)

SELECT
    budget AS movie_budget,
    id AS movie_id,
    original_language AS movie_original_language,
    overview AS movie_overview,
    popularity AS movie_popularity,
    release_date AS movie_release_date,
    revenue AS movie_revenue,
    status AS movie_status,
    tagline AS movie_tagline,
    title AS movie_title,
    vote_average AS movie_vote_average,
    vote_count AS movie_vote_count,
    _dlt_id

    {#- Unused columns:
    - adult
    - backdrop_path
    - imdb_id
    - original_title
    - poster_path
    - runtime
    - video
    - recommendations__page
    - recommendations__total_pages
    - reviews__page
    - reviews__total_pages
    - reviews__total_results
    - similar__page
    - similar__total_pages
    - similar__total_results
    - _dlt_load_id
    - belongs_to_collection_name
    - belongs_to_collection__poster_path
    - belongs_to_collection__backdrop_path
    #}

FROM source
