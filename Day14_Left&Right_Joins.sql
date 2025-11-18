--Show all staff members and their schedule info (including those with no schedule entries).
SELECT s.staff_id,s.staff_name,s.role,s.service,ss.week,ss.present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id;
--List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT sw.service,sw.week,s.staff_id,s.staff_name
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service;
--Display all patients and their service’s weekly statistics (if available).
SELECT p.patient_id,w.event, p.age,p.service,p.arrival_date,
    p.name AS patient_name,
    EXTRACT(WEEK FROM p.arrival_date) AS arrival_week, 
    EXTRACT(MONTH FROM p.arrival_date) AS arrival_month,   
    CASE
        WHEN p.satisfaction >= w.patient_satisfaction THEN 'Above avg'
        ELSE 'Below avg'
    END AS satisfaction_rating
FROM services_weekly w
RIGHT JOIN patients p ON EXTRACT(WEEK FROM p.arrival_date) = w.week  
    AND EXTRACT(MONTH FROM p.arrival_date) = w.month          
    AND p.service = w.service
ORDER BY arrival_date;
--Daily Challenge:Create a staff utilisation report showing all staff members and the count of weeks
--they were present. Include staff even with no schedule records. Order by weeks present descending.
SELECT s.staff_id,s.staff_name,s.role,s.service,
  SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC;


