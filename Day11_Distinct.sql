--List all unique services in the patients table.
SELECT DISTINCT service, name
FROM patients;
--Find all unique staff roles in the hospital.
SELECT DISTINCT role, staff_name
FROM staff
--Get distinct months from the services_weekly table.
SELECT DISTINCT month
FROM services_weekly;

--Daily Challenge:Find all unique combinations of service and event type 
--from the services_weekly table where events are not null or none, along 
--with the count of occurrences for each combination. Order by count descending.
SELECT DISTINCT service,event, COUNT(*) AS event_count
FROM services_weekly
WHERE event IS NOT NULL AND event != 'none'
GROUP BY event,service
ORDER BY event_count DESC;
