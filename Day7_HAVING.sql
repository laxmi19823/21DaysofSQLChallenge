--Find services that have admitted more than 500 patients in total.
SELECT service, SUM(patients_admitted) AS admitted
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted) > 500
ORDER BY admitted DESC;
--Show services where average patient satisfaction is below 75 (adjusted to 80)
SELECT service, ROUND(AVG(patient_satisfaction),2) AS Avg_satisfaction
FROM services_weekly
GROUP BY service
HAVING AVG(patient_satisfaction) < 80
ORDER BY Avg_satisfaction DESC;
--List weeks where total staff presence across all services was less than 50.
SELECT week,SUM(present) AS total_present
FROM staff_schedule
GROUP BY week
HAVING SUM(present) <50
ORDER BY total_present DESC;

--DAILY VHALEENGE:Identify services that refused more than 100 patients in total 
--and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction
SELECT service, ROUND(AVG(patient_satisfaction),2) AS Avg_satisfaction, SUM(patients_refused) AS total_patients_refused
FROM services_weekly
GROUP BY service
HAVING ROUND(AVG(patient_satisfaction),2) < 80 AND SUM(patients_refused) > 100
ORDER BY service;