WITH raw AS (
    SELECT DISTINCT *
    FROM {{ source('public', 'incidents_staging') }}
    WHERE inc_sys_created_on <> 'inc_sys_created_on' 
),

cleaned AS (
    SELECT
        inc_business_service,
        inc_category,
        inc_number,
        inc_priority,
        NULLIF(inc_sla_due, 'UNKNOWN') AS inc_sla_due,
        CAST(inc_sys_created_on AS TIMESTAMP) AS inc_sys_created_on,
        CAST(inc_resolved_at AS TIMESTAMP) AS inc_resolved_at,
        inc_assigned_to,
        inc_state,
        inc_cmdb_ci,
        inc_caller_id,
        inc_short_description,
        inc_assignment_group,
        inc_close_code,
        inc_close_notes
    FROM raw
)

SELECT * FROM cleaned
