--Count the total number of patients in the hospital
SELECT COUNT(*) AS total_patients
FROM patients;
--Calculate the average satisfaction score of all patients
SELECT AVG(satisfaction) AS average_satisfaction
FROM patients;
--Find the minimum and maximum age of patients
SELECT MIN(age) AS young_patient, MAX(age) AS old_patient
FROM patients;
--Daily Challenge:Calculate the total number of patients admitted, total patients refused, and 
--the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
SELECT 
   SUM(patients_admitted) AS total_admitted,
   SUM(patients_refused)  AS total_refused,
   Round(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM services_weekly;
