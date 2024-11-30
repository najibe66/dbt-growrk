{{
    config(
        schema='silver',
        materialized='table',
        cluster_by=['name', 'gender', 'state'],
        tags=['silver']
    )
}}



SELECT
    UPPER(COALESCE(state, 'NOT INFORMED'))  AS state,
    UPPER(COALESCE(gender, 'NOT INFORMED')) AS gender,

    COALESCE(YEAR, 0)                       AS year,

    COALESCE(
        REGEXP_REPLACE(NORMALIZE(name, NFD), r'\pM', ''), 'Not Informed'
    )                                       AS name,
    COALESCE(number, 0)                     AS number,
    _internal_sequence                      AS sequence,
    CURRENT_TIMESTAMP()                     AS _internal_sequence
FROM {{ ref('bronze__usa_names_1910_current') }}