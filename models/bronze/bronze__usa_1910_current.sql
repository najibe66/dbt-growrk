{{
    config(
        schema='bronze',
        materialized='table',
        partition_by={'field': '_internal_sequence', 'data_type': 'timestamp', 'granularity': 'day'},
        cluster_by=['name', 'gender', 'state'],
        tags=['raw']
    )
}}



SELECT 
    state,
    gender,
    year,
    name,
    number,
    _internal_sequence  AS sequence,
    CURRENT_TIMESTAMP() AS _internal_sequence
FROM {{ ref('raw__usa_1910_current') }}
{% if is_incremental() %}
    WHERE _internal_sequence > (SELECT MAX(_internal_sequence) FROM {{ this }})
{% endif %}
