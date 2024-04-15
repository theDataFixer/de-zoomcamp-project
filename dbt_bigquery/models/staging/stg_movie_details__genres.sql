{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'movie_details__genres') }}
)

SELECT
    id AS movie_genre_id,
    name AS movie_genre_name,
    _dlt_parent_id,
    _dlt_id

    {#- Unused colmns:
    - _dlt_list_idx
    #}

FROM source
