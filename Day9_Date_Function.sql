-- Extract the year from all patient arrival dates
SELECT patient_id,name, EXTRACT(YEAR FROM arrival_date) AS Arrival_Year
FROM patients;
--Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT 
    patient_id,
    name,
    arrival_date,
    departure_date,
    (departure_date - arrival_date) AS stay_length
FROM patients;

--Find all patients who arrived in a specific month
SELECT 
    patient_id,
    name,
    arrival_date
FROM patients
WHERE EXTRACT(MONTH FROM arrival_date) = 1;  -- January

--Daily Challenge:Calculate the average length of stay (in days)
--for each service, showing only services where the average stay is more 
--than 7 days. Also show the count of patients and order by average stay descending.
SELECT 
    service,
    COUNT(patient_id) AS patient_count,
    ROUND(AVG(departure_date - arrival_date), 2) AS avg_stay_days
FROM patients
GROUP BY service
HAVING AVG(departure_date - arrival_date) > 7
ORDER BY avg_stay_days DESC;

