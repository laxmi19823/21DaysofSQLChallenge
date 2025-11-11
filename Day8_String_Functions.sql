--Convert all patient names to uppercase.
SELECT UPPER(name) AS NAMES
FROM patients;
--Find the length of each staff member's name.
SELECT LENGTH(staff_name) AS length_of_staff_names
FROM staff;
--Concatenate staff_id and staff_name with a hyphen separator.
SELECT CONCAT(staff_id,'-',staff_name) AS ID_NAME
FROM staff;
--Daily Challenge:Create a patient summary that shows patient_id, full name in uppercase, 
--service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', 
--else 'Minor'),and name length. Only show patients whose name length is greater than 10 characters.

SELECT
    patient_id,
    UPPER(name) AS full_name_upper,
    LOWER(service) AS service_lower,
    CASE
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;
