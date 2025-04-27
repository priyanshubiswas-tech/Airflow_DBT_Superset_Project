WITH ticket_status AS (
    SELECT
        inc_assignment_group,
        COUNT(*) AS total_tickets,
        SUM(CASE WHEN LOWER(inc_state) = 'closed' THEN 1 ELSE 0 END) AS closed_tickets
    FROM {{ ref('clean_incidents') }}
    GROUP BY inc_assignment_group
)

SELECT
    inc_assignment_group,
    total_tickets,
    closed_tickets,
    ROUND((closed_tickets::DECIMAL / total_tickets) * 100, 2) AS closure_rate_percentage
FROM ticket_status
ORDER BY closure_rate_percentage DESC