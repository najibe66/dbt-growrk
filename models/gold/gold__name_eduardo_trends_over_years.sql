{{
    config(
        schema='gold',
        materialized='table',
        cluster_by=['year'],
        tags=['gold']
    )
}}

WITH name_trends AS (
    SELECT
        year,
        COALESCE(COUNT(1), 0) AS name_count
    FROM {{ ref('silver__usa_names_1910_current') }}
    WHERE name = 'Eduardo' 
    GROUP BY 1
)

SELECT
    year,
    name_count,
    COALESCE(LAG(name_count) OVER (ORDER BY year), 0)              AS previous_year_count,
    name_count - COALESCE(LAG(name_count) OVER (ORDER BY year), 0) AS year_over_year_change
FROM name_trends