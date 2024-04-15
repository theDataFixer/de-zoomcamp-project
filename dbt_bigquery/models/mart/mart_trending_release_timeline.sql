-- File: mart/trending_release_timeline.sql
{{ config(materialized='table') }}

SELECT
    dt.trending_type AS content_type,
    EXTRACT(YEAR FROM dt.trending_release_date) AS release_year,
    EXTRACT(MONTH FROM dt.trending_release_date) AS release_month,
    COUNT(*) AS trending_count

FROM {{ ref('dim_trending_info') }} AS dt
GROUP BY release_year, release_month, content_type
ORDER BY release_year, release_month
