-- File: mart/popular_genre_distribution.sql
{{ config(materialized='table') }}

SELECT
    fp.content_type,
    dpg.content_genre_name,
    COUNT(DISTINCT fp.content_id) AS content_count

FROM {{ ref('dim_popular_content_details_genres' ) }} AS dpg
INNER JOIN {{ ref('fct_popular_content_details') }} AS fp
    ON dpg._dlt_parent_id = fp._dlt_id
GROUP BY fp.content_type, dpg.content_genre_name
