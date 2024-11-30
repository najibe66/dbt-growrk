{{
    config(
        schema='bronze',
        materialized='table',
        cluster_by=['name', 'gender', 'state'],
        tags=['bronze']
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

