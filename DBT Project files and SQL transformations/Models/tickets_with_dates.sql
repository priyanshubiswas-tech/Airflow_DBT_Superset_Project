SELECT 
    *,
    EXTRACT(YEAR FROM inc_sys_created_on) AS created_year,
    EXTRACT(MONTH FROM inc_sys_created_on) AS created_month,
    EXTRACT(DAY FROM inc_sys_created_on) AS created_day
FROM {{ ref('clean_incidents') }}