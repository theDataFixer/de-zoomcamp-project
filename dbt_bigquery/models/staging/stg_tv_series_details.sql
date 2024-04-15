{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'tv_series_details') }}
)

SELECT
    first_air_date AS tv_series_first_air_date,
    homepage AS tv_series_homepage,
    id AS tv_series_id,
    in_production AS tv_series_in_production,
    last_air_date AS tv_series_last_air_date,
    name AS tv_series_name,
    number_of_seasons AS tv_series_number_of_seasons,
    original_language AS tv_series_original_language,
    overview AS tv_series_overview,
    popularity AS tv_series_popularity,
    status AS tv_series_status,
    type AS tv_series_type,
    vote_average AS tv_series_vote_average,
    vote_count AS tv_series_vote_count,
    _dlt_id

    {#- Unused columns:
    - adult
    - backdrop_path
    - last_episode_to_air__id
    - last_episode_to_air__name
    - last_episode_to_air__overview
    - last_episode_to_air__vote_average
    - last_episode_to_air__vote_count
    - last_episode_to_air__air_date
    - last_episode_to_air__episode_number
    - last_episode_to_air__episode_type
    - last_episode_to_air__production_code
    - last_episode_to_air__runtime
    - last_episode_to_air__season_number
    - last_episode_to_air__show_id
    - last_episode_to_air__still_path
    - next_episode_to_air__name
    - next_episode_to_air__overview
    - next_episode_to_air__air_date
    - next_episode_to_air__episode_number
    - next_episode_to_air__id
    - next_episode_to_air__vote_average
    - next_episode_to_air__vote_count
    - next_episode_to_air__episode_type
    - next_episode_to_air__production_code
    - next_episode_to_air__runtime
    - next_episode_to_air__season_number
    - next_episode_to_air__show_id
    - poster_path
    - tagline
    - recommendations__page
    - recommendations__total_pages
    - recommendations_total_results
    - reviews__page
    - reviews__total_pages
    - reviews__total_results
    - similar__page
    - similar__total_pages
    - similar__total_results
    - _dlt_load_id
    - next_episode_to_air_still_path
    #}

FROM source
