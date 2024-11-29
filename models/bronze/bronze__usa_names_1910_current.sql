{{
    config(
        schema='bronze',
        materialized='incremental',
        partition_by={'field': '_internal_sequence', 'data_type': 'timestamp', 'granularity': 'day'},
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
{% if is_incremental() %}
WHERE 
    year >= (SELECT MIN(year) FROM {{ this }}) --scan the entirely year column
    AND CURRENT_TIMESTAMP() >= (SELECT MAX(_internal_sequence) FROM {{ this }}) --capture only rows that year field has update
{% endif %}

