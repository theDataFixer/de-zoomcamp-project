-- File: intermediate/dim_popular_content_details_reviews.sql
{{ config(materialized='table') }}

WITH movie_reviews AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_reviews_sk,
      _dlt_parent_id,
      movie_review_author_name AS content_review_author_name,
      movie_review_author_content AS content_review_author_content,
      movie_review_author_created_at AS content_review_author_created_at,
      movie_review_id AS content_review_id,
      movie_review_author_updated_at AS content_review_author_updated_at,
      movie_review_url AS content_review_url
    FROM {{ ref('stg_movie_details__reviews__results') }}
),

tv_series_reviews AS (
    SELECT
      {{ dbt_utils.generate_surrogate_key(['_dlt_parent_id']) }} AS dim_popular_content_details_reviews_sk,
      _dlt_parent_id,
      tv_series_review_author AS content_review_author_name,
      tv_series_review_author_content AS content_review_author_content,
      tv_series_review_author_created_at AS content_review_author_created_at,
      tv_series_review_id AS content_review_id,
      tv_series_review_author_updated_at AS content_review_author_updated_at,
      tv_series_review_url AS content_review_url
    FROM {{ ref('stg_tv_series_details__reviews__results') }}
)

SELECT * FROM movie_reviews
UNION ALL
SELECT * FROM tv_series_reviews
