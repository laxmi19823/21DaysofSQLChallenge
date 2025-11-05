--Practice Questions:1. List all patients sorted by age in descending order.
SELECT *
FROM patients
ORDER BY age DESC ;
--Show all services_weekly data sorted by week_number in ascending order and patients_request in descending order.
SELECT *
FROM services_weekly
ORDER BY week ASC, patients_request DESC;
--Display all staff members sorted alphabetically by their names.
SELECT *
FROM staff
ORDER BY staff_name;
--DAILY CHAALENGE: Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, 
--patients_refused, and patients_request. Sort by patients_refused in descending order.
SELECT week, service, patients_refused, patients_request
FROM services_weekly
ORDER BY patients_refused DESC
LIMIT 5;