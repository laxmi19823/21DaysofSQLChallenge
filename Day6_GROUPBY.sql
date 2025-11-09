--Practice Questions: 1. Count the number of patients by each service.
SELECT COUNT(name) AS Total_patients, service
FROM patients
GROUP BY service;
--Calculate the average age of patients grouped by service.
SELECT AVG(age) AS Average_age, service
FROM patients
GROUP BY service;
--Find the total number of staff members per role.
SELECT COUNT(*) AS total_staff, role
FROM staff
GROUP BY role;
--DAILY CHALLENGE:For each hospital service, calculate the total number of patients admitted, total patients refused, 
--and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT service, SUM(patients_admitted) AS total_patients_admitted,
                SUM(patients_refused) AS total_patients_refused,
				ROUND(SUM(patients_admitted)*100/(SUM(patients_admitted)+SUM(patients_refused))) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;