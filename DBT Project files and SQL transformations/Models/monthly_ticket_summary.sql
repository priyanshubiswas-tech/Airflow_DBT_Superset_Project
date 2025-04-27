WITH monthly_data AS (
    SELECT
        DATE_TRUNC('month', inc_sys_created_on) AS ticket_month,
        COUNT(*) AS total_tickets,
        AVG(EXTRACT(EPOCH FROM (inc_resolved_at - inc_sys_created_on)) / 3600) AS avg_resolution_time_hrs,
        SUM(CASE WHEN LOWER(inc_state) = 'closed' THEN 1 ELSE 0 END)::DECIMAL / COUNT(*) * 100 AS closure_rate_percentage
    FROM {{ ref('clean_incidents') }}
    WHERE inc_sys_created_on IS NOT NULL
    GROUP BY DATE_TRUNC('month', inc_sys_created_on)
)

SELECT
    ticket_month,
    total_tickets,
    ROUND(avg_resolution_time_hrs, 2) AS avg_resolution_time_hrs,
    ROUND(closure_rate_percentage, 2) AS closure_rate_percentage
FROM monthly_data
ORDER BY ticket_month