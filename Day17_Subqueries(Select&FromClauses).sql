--Show each patient with their service's average satisfaction as an additional column.
SELECT
    stats.service,
    stats.total_patients,
    stats.avg_satisfaction
FROM (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
) AS stats;

--Create a derived table of service statistics and query from it.
SELECT
    s.staff_id,
    s.staff_name,
    s.service,
    (
        SELECT COUNT(*)
        FROM patients p
        WHERE p.service = s.service
    ) AS service_patient_count
FROM staff s;
--Display staff with their service's total patient count as a calculated field.
SELECT
    s.staff_id,
    s.staff_name,
    s.service,
    (
        SELECT COUNT(*)
        FROM patients p
        WHERE p.service = s.service
    ) AS service_patient_count
FROM staff s;
--Daily Challenge:Create a report showing each service with: service name, total patients admitted,
--the difference between their total admissions and the average admissions across all services, 
--and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT
    t.service,
    t.total_admitted,
    t.total_admitted - t.avg_admitted AS diff_from_avg,
    CASE
        WHEN t.total_admitted > t.avg_admitted THEN 'Above Average'
        WHEN t.total_admitted = t.avg_admitted THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        (
            SELECT AVG(total)
            FROM (
                SELECT SUM(patients_admitted) AS total
                FROM services_weekly
                GROUP BY service
            ) AS x
        ) AS avg_admitted
    FROM services_weekly
    GROUP BY service
) AS t
ORDER BY t.total_admitted DESC;



