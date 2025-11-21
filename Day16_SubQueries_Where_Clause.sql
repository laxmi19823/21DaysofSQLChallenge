--Find patients who are in services with above-average staff count.
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM staff
    GROUP BY service
    HAVING COUNT(*) > (
        SELECT AVG(staff_count)
        FROM (
            SELECT service, COUNT(*) AS staff_count
            FROM staff
            GROUP BY service
        ) s
    )
);
--List staff who work in services that had any week with patient satisfaction below 70.
SELECT *
FROM staff
WHERE service IN (
    SELECT DISTINCT service
    FROM services_weekly
    WHERE patient_satisfaction < 70
);
--Show patients from services where total admitted patients exceed 1000.
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING SUM(patients_admitted) > 1000
);
--Daily Challenge:Find all patients who were admitted to services that had
--at least one week where patients were refused AND the average patient 
--satisfaction for that service was below the overall hospital average satisfaction. 
--Show patient_id, name, service, and their personal satisfaction score.
SELECT p.patient_id, p.name, p.service, p.satisfaction
FROM patients p
WHERE p.service IN (
    -- Services that had at least one week with refusals
    SELECT sw1.service
    FROM services_weekly sw1
    WHERE EXISTS (
        SELECT 1
        FROM services_weekly sw2
        WHERE sw2.service = sw1.service
          AND sw2.patients_refused > 0
    )
)
AND p.service IN (
    -- Services whose avg satisfaction < hospital-wide avg satisfaction
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING AVG(patient_satisfaction) < (
        SELECT AVG(patient_satisfaction)
        FROM services_weekly
    )
);
