--Find all weeks in services_weekly where no special event occurred.
SELECT week,SUM(
CASE 
    WHEN event = 'none' OR event IS NULL THEN 1
    ELSE 0
END) AS Count_of_no_special_event
FROM services_weekly
GROUP BY week;
--Count how many records have null or empty event values.
SELECT COUNT(*) AS null_or_empty_event_count
FROM services_weekly
WHERE event IS NULL OR event = 'none';
--List all services that had at least one week with a special event.
SELECT service,SUM(
CASE
     WHEN event != 'none' AND event IS NOT NULL THEN 1
     ELSE 0
END) AS weeks_with_spl_events
FROM services_weekly
WHERE event IS NOT NULL AND event != 'none'
GROUP BY service;
--Daily Challenge:Analyze the event impact by comparing weeks with events
--vs weeks without events. Show: event status ('With Event' or 'No Event'), 
--count of weeks, average patient satisfaction, and average staff morale. 
--Order by average patient satisfaction descending.
SELECT
CASE
    WHEN event IS DISTINCT FROM 'none' AND event IS NOT NULL THEN 'With Event'
    ELSE 'No Event'
END AS Event_Status,
COUNT(week) AS Count_of_weeks,
ROUND(AVG(patient_satisfaction), 2) AS Avg_Patient_Satisfaction,
ROUND(AVG(staff_morale), 2) AS Avg_Staff_Morale
FROM services_weekly
GROUP BY Event_Status
ORDER BY Avg_Patient_Satisfaction DESC;


  
