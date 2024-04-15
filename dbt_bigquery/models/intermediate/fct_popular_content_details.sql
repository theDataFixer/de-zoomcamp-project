-- File: intermediate/fct_popular_content_details.sql
{{ config(materialized='table') }}

WITH cte_movie_reviews AS (
    SELECT
        _dlt_parent_id,
        movie_review_author_rating,
        ROW_NUMBER() OVER(
          PARTITION BY _dlt_parent_id
          ORDER BY movie_review_author_rating DESC
        ) AS rnk_review
    FROM {{ ref('stg_movie_details__reviews__results') }}
),

cte_movie_similar AS (
    SELECT
        _dlt_parent_id,
        movie_similar_popularity,
        movie_similar_vote_average,
        movie_similar_vote_count,
        ROW_NUMBER() OVER(
          PARTITION BY _dlt_parent_id
          ORDER BY movie_similar_popularity DESC, movie_similar_vote_average DESC, movie_similar_vote_count DESC
        ) AS rnk_similar
    FROM {{ ref('stg_movie_details__similar__results') }}
),

cte_movies_details AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['smd._dlt_id']) }} AS fct_popular_content_details_sk,
        smd._dlt_id,
        smd.movie_id AS content_id,
        'Movie' AS content_type,
        smd.movie_budget AS content_budget,
        smd.movie_popularity AS content_popularity,
        smd.movie_revenue AS content_revenue,
        smd.movie_vote_average AS content_vote_average,
        smd.movie_vote_count AS content_vote_count,
        cmr.movie_review_author_rating AS content_review_author_rating,
        cms.movie_similar_popularity AS content_similar_popularity,
        cms.movie_similar_vote_average AS content_similar_vote_average,
        cms.movie_similar_vote_count AS content_similar_vote_count
    FROM {{ ref('stg_movie_details') }} AS smd
    LEFT JOIN cte_movie_reviews cmr
      ON smd._dlt_id = cmr._dlt_parent_id AND cmr.rnk_review = 1
    LEFT JOIN cte_movie_similar cms
      ON smd._dlt_id = cms._dlt_parent_id AND cms.rnk_similar = 1
),

cte_tv_series_reviews AS (
    SELECT
        _dlt_parent_id,
        tv_series_review_author_rating,
        ROW_NUMBER() OVER(
          PARTITION BY _dlt_parent_id
          ORDER BY tv_series_review_author_rating DESC
        ) AS rnk_review
    FROM {{ ref('stg_tv_series_details__reviews__results') }}
),

cte_tv_series_similar AS (
    SELECT
        _dlt_parent_id,
        tv_series_similar_popularity,
        tv_series_similar_vote_average,
        tv_series_similar_vote_count,
        ROW_NUMBER() OVER(
          PARTITION BY _dlt_parent_id
          ORDER BY tv_series_similar_popularity DESC, tv_series_similar_vote_average DESC, tv_series_similar_vote_count DESC
        ) AS rnk_similar
    FROM {{ ref('stg_tv_series_details__similar__results') }}
),

cte_tv_series_details AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['std._dlt_id']) }} AS fct_popular_content_details_sk,
        std._dlt_id,
        std.tv_series_id AS content_id,
        'TV Series' AS content_type,
        NULL AS content_budget, -- Budget info not available for TV Series
        std.tv_series_popularity AS content_popularity,
        NULL AS content_revenue, -- Revenue info not available for TV Series
        std.tv_series_vote_average AS content_vote_average,
        std.tv_series_vote_count AS content_vote_count,
        ctr.tv_series_review_author_rating AS content_review_author_rating,
        cts.tv_series_similar_popularity AS content_similar_popularity,
        cts.tv_series_similar_vote_average AS content_similar_vote_average,
        cts.tv_series_similar_vote_count AS content_similar_vote_count
    FROM {{ ref('stg_tv_series_details') }} std
    LEFT JOIN cte_tv_series_reviews ctr
      ON std._dlt_id = ctr._dlt_parent_id AND ctr.rnk_review = 1
    LEFT JOIN cte_tv_series_similar cts
      ON std._dlt_id = cts._dlt_parent_id AND cts.rnk_similar = 1
)

SELECT * FROM cte_movies_details
UNION ALL
SELECT * FROM cte_tv_series_details
