{{ config(materialized='view') }}

WITH source AS (
    SELECT *

    FROM {{ source('movie_data', 'tv_series_details__reviews__results') }}
)

SELECT
    author AS tv_series_review_author,
    author_details__rating AS tv_series_review_author_rating,
    content AS tv_series_review_author_content,
    created_at AS tv_series_review_author_created_at,
    id AS tv_series_review_id,
    updated_at AS tv_series_review_author_updated_at,
    url AS tv_series_review_url,
    _dlt_parent_id,
    _dlt_id

    {#- Unused columns:
    - author_details__name
    - author_details__username
    - _dlt_list_idx
    - author_details__avatar_path
    #}

FROM source
