{{
    config(
        schema='gold',
        materialized='table',
        cluster_by=['name', 'year'],
        tags=['gold']
    )
}}


SELECT
    year,
    name,
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_name_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_name_count
FROM {{ ref('silver__usa_names_1910_current') }}
GROUP BY 1, 2

