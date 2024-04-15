{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'trending_tv_series__genre_ids') }}
)

SELECT
    value AS trending_tv_series_genre_id_value,
    _dlt_id,
    _dlt_parent_id

    {#- Unused columns:
    - _dlt_list_idx
    #}

FROM source
