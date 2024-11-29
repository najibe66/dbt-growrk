{{
    config(
        schema='raw',
        materialized='table',
        tags=['raw']
    )
}}

SELECT 
    state,
    gender,
    year,
    name,
    number,
    CURRENT_TIMESTAMP() AS _internal_sequence
FROM {{ source('bigquery_public_data', 'usa_1910_current') }}
