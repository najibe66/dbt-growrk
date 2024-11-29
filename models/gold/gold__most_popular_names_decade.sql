{{
    config(
        schema='gold',
        materialized='table',
        cluster_by=['name', 'decade'],
        tags=['gold']
    )
}}



WITH names_with_decade AS (
    SELECT
        name,
        CAST((FLOOR(year / 10) * 10) AS INT64) AS decade,
        COUNT(1)                               AS name_count  
    FROM {{ ref('silver__usa_names_1910_current')}}
    GROUP BY 1, 2
)


SELECT
    name,
    decade,
    name_count
FROM names_with_decade
QUALIFY ROW_NUMBER() OVER (PARTITION BY decade ORDER BY name_count DESC) <= 5
