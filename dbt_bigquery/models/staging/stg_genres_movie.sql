{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'genres_movie') }}
)

SELECT
    id AS genre_movie_id,
    name AS genre_movie_name,
    _dlt_id

    {#- Unused columns:
    - _dlt_load_id
    #}

FROM source
