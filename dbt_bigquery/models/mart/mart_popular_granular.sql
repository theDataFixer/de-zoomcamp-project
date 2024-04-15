-- File: mart/granular_popular_content.sql
{{ config(materialized='table') }}

SELECT
    fpcd.content_type,
    fpcd.content_budget,
    fpcd.content_popularity,
    fpcd.content_revenue,
    fpcd.content_vote_average,
    fpcd.content_vote_count,
    fpcd.content_review_author_rating,
    fpcd.content_similar_popularity,
    fpcd.content_similar_vote_average,
    fpcd.content_similar_vote_count,
    pc_info.content_original_language,
    pc_info.content_overview,
    pc_info.content_release_date,
    pc_info.content_status,
    pc_info.content_title,
    pc_genres.content_genre_name,
    pc_reviews.content_review_author_name,
    pc_reviews.content_review_author_content,
    pc_reviews.content_review_author_created_at,
    pc_reviews.content_review_author_updated_at,
    pc_reviews.content_review_url,
    pc_similar.content_similar_overview,
    pc_similar.content_similar_release_date,
    pc_similar.content_similar_title

FROM {{ ref('fct_popular_content_details') }} AS fpcd
LEFT JOIN {{ ref('dim_popular_content_details_info') }} AS pc_info
  ON fpcd._dlt_id = pc_info._dlt_id
LEFT JOIN {{ ref('dim_popular_content_details_genres') }} AS pc_genres
  ON fpcd._dlt_id = pc_genres._dlt_parent_id
LEFT JOIN {{ ref('dim_popular_content_details_reviews') }} AS pc_reviews 
  ON fpcd._dlt_id = pc_reviews._dlt_parent_id
LEFT JOIN {{ ref('dim_popular_content_details_similar') }} AS pc_similar 
  ON fpcd._dlt_id = pc_similar._dlt_parent_id
