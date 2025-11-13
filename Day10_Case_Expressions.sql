--Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT name, satisfaction AS satisfaction_score,
CASE
    WHEN satisfaction <75 THEN 'LOW'
    WHEN satisfaction <90 THEN 'MEDIUM'
    ELSE 'HIGH'
END as satisfaction_score
FROM patients;
--Label staff roles as 'Medical' or 'Support' based on role type.
SELECT staff_name, role,
CASE
   WHEN Role = 'nursing_assistant' THEN 'SUPPORT'
   ELSE 'MEDICAL'
END AS Role_Type
FROM staff;
--Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT name,age AS AGE_Group,
CASE 
    WHEN age >= 18 THEN 'CHILD'
	WHEN age >= 40 THEN 'YOUNG ADULT'
	WHEN age >= 65 THEN 'MIDDLE-AGED'
	ELSE 'SENIOR CITIZEN'
END AS Age_Group
FROM patients;
--Daily Challenge:Create a service performance report showing service name,
--total patients admitted, and a performance category based on the following:
--'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65,
--otherwise 'Needs Improvement'. Order by average satisfaction descending.
SELECT service,
       SUM(patients_admitted) AS total_patients_admitted,
	   ROUND(AVG(patient_satisfaction)) AS avg_satifaction,       
CASE
   WHEN AVG(patient_satisfaction) >= 85 THEN 'EXCELLENT'
   WHEN AVG(patient_satisfaction) >= 75 THEN 'GOOD'
   WHEN AVG(patient_satisfaction) >= 65 THEN 'FAIR'
   ELSE 'NEEDS IMPROVEMENT'
END AS patients_performance
FROM serviceS_weekly
GROUP BY service 
ORDER BY avg_satifaction DESC;