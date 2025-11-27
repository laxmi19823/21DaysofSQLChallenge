--Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(satisfaction) AS avg_satisfaction,
        AVG(age) AS avg_age
    FROM patients
    GROUP BY service
)
SELECT *
FROM service_stats
ORDER BY avg_satisfaction DESC;

--Use multiple CTEs to break down a complex query into logical steps.
WITH
patient_stats AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
weekly_stats AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
),
staff_stats AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
)

SELECT
    ps.service,
    ps.total_patients,
    ps.avg_satisfaction,
    ws.total_admitted,
    ws.total_refused,
    ss.total_staff
FROM patient_stats ps
LEFT JOIN weekly_stats ws ON ps.service = ws.service
LEFT JOIN staff_stats ss ON ps.service = ss.service
ORDER BY ps.avg_satisfaction DESC;

--Build a CTE for staff utilization and join it with patient data.
WITH staff_util AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
patient_summary AS (
    SELECT
        service,
        COUNT(*) AS patient_count,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
)

SELECT
    pu.service,
    pu.patient_count,
    pu.avg_satisfaction,
    su.total_staff
FROM patient_summary pu
LEFT JOIN staff_util su ON pu.service = su.service
ORDER BY pu.avg_satisfaction DESC;

--Daily Challenge:Create a comprehensive hospital performance dashboard using CTEs.
--Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction),
--2) Staff metrics per service (total staff, avg weeks present),
--3) Patient demographics per service (avg age, count). Then combine all three CTEs 
--to create a final report showing service name, all calculated metrics, and an overall
--performance score (weighted average of admission rate and satisfaction). Order by performance score descending.
WITH
service_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
patient_demo AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(age) AS avg_age
    FROM patients
    GROUP BY service
),
dashboard AS (
    SELECT
        sm.service,
        sm.total_admitted,
        sm.total_refused,
        sm.avg_satisfaction,
        st.total_staff,
        pd.total_patients,
        pd.avg_age,

        ROUND(
            (
                (1.0 * sm.total_admitted / NULLIF((sm.total_admitted + sm.total_refused), 0)) * 0.6
                +
                (sm.avg_satisfaction / 100.0) * 0.4
            ) * 100,
        2) AS performance_score
    FROM service_metrics sm
    LEFT JOIN staff_metrics st ON sm.service = st.service
    LEFT JOIN patient_demo pd ON sm.service = pd.service
)

SELECT *
FROM dashboard
ORDER BY performance_score DESC;
