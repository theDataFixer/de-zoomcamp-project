{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'genres_tv_series') }}
)

SELECT
    id AS genre_tv_series_id,
    name AS genre_tv_series_name,
    _dlt_id

    {#- Unused columns:
    - _dlt_load_id
    #}

FROM source
