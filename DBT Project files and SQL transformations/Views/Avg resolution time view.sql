CREATE OR REPLACE VIEW avg_resolution_time AS
WITH resolution_times AS (
    SELECT
        inc_category,
        inc_priority,
        EXTRACT(EPOCH FROM (inc_resolved_at - inc_sys_created_on)) / 3600 AS resolution_time_hrs
    FROM clean_incidents
    WHERE inc_resolved_at IS NOT NULL
      AND inc_sys_created_on IS NOT NULL
)
SELECT
    inc_category,
    inc_priority,
    ROUND(AVG(resolution_time_hrs), 2) AS avg_resolution_time_hrs
FROM resolution_times
GROUP BY
    inc_category,
    inc_priority
ORDER BY
    inc_category,
    inc_priority;