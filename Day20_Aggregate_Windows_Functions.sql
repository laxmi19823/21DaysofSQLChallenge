--Create a CTE to calculate service statistics, then query from it
WITH service_stats AS (
    SELECT
        service,
        COUNT(*) AS total_weeks,
        SUM(patients_admitted) AS total_admissions,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
)
SELECT *
FROM service_stats
ORDER BY service;
--Use multiple CTEs to break down a complex query into logical steps
WITH weekly_data AS (
    SELECT
        service,
        week,
        patients_admitted,
        patient_satisfaction
    FROM services_weekly
),

service_avg AS (
    SELECT
        service,
        AVG(patients_admitted) AS avg_admissions,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),

combined AS (
    SELECT
        w.service,
        w.week,
        w.patients_admitted,
        w.patient_satisfaction,
        ROUND(w.patients_admitted - s.avg_admissions, 2) AS diff_from_avg_admissions,
        ROUND(w.patient_satisfaction - s.avg_satisfaction, 2) AS diff_from_avg_satisfaction
    FROM weekly_data w
    JOIN service_avg s
        ON w.service = s.service
)

SELECT *
FROM combined
ORDER BY service, week;
--Build a CTE for staff utilization and join it with patient data
WITH service_totals AS (
    SELECT 
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
doctor_counts AS (
    SELECT 
        service,
        COUNT(*) AS doctor_count
    FROM staff
    WHERE role = 'doctor'
    GROUP BY service
)
SELECT 
    d.service,
    d.doctor_count,
    s.total_staff,
    ROUND((d.doctor_count::decimal / s.total_staff) * 100, 2) AS doctor_percentage
FROM doctor_counts d
JOIN service_totals s
    ON d.service = s.service;
-- challenge : Create a trend analysis showing for each service and week: 
-- week number, patients_admitted, running total of patients admitted (cumulative),
-- 3-week moving average of patient satisfaction (current week and 2 prior weeks),
-- and the difference between current week admissions and the service average. 
-- Filter for weeks 10–20 only.
WITH service_avg AS (
    SELECT
        service,
        AVG(patients_admitted) AS avg_admitted
    FROM services_weekly
    GROUP BY service
)

SELECT
    sw.service,
    sw.week,
    sw.patients_admitted,

    SUM(sw.patients_admitted) OVER (
        PARTITION BY sw.service 
        ORDER BY sw.week
    ) AS running_total,

    ROUND(
        AVG(sw.patient_satisfaction) OVER (
            PARTITION BY sw.service 
            ORDER BY sw.week 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3weeks,

    ROUND((sw.patients_admitted - sa.avg_admitted), 2) AS diff_from_service_avg

FROM services_weekly sw
JOIN service_avg sa 
    ON sw.service = sa.service
WHERE sw.week BETWEEN 10 AND 20
ORDER BY sw.service, sw.week;
