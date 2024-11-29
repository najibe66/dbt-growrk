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
        COUNT(1) AS name_count
    FROM {{ ref('silver__usa_names_1910_current') }}
    WHERE name = 'Eduardo' 
    GROUP BY 1
)

SELECT
    year,
    name_count,
    LAG(name_count) OVER (ORDER BY year)              AS previous_year_count,
    name_count - LAG(name_count) OVER (ORDER BY year) AS year_over_year_change
FROM name_trends