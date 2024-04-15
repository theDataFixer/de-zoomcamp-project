{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'tv_series_details__genres') }}
)

SELECT
    id AS tv_series_genre_id,
    name AS tv_series_genre_name,
    _dlt_parent_id,
    _dlt_id

    {#- Unused columns:
    - _dlt_list_idx
    #}

FROM source
