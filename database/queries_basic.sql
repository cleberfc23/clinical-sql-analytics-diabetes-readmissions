-- -- 1. Dataset sanity check
-- SELECT  COUNT(*) AS total_encounters,
--         COUNT(DISTINCT patient_nbr) AS unique_patients,
--         ROUND(100*SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/COUNT(*),1) AS readmission_rate_pct
-- FROM encounters;

-- -- 2. Encounters by Age Group
-- SELECT
--     p.age,
--     COUNT(*) AS encounters
-- FROM encounters e
-- JOIN patients p 
-- ON p.patient_nbr = e.patient_nbr
-- GROUP BY p.age
-- ORDER BY p.age;

-- -- 3. Readmitted Encounters by Age Group
-- SELECT
--     p.age,
--     SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
--     as readmitted_encounters_by_age
-- FROM encounters e
-- JOIN patients p
-- ON e.patient_nbr = p.patient_nbr
-- GROUP BY p.age
-- ORDER By p.age;

-- -- 4. Readmission Rate by Age Group
-- SELECT
--     p.age,
--     COUNT(*) AS encounters,
--     ROUND(100.0 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/COUNT(*), 1) AS readmission_rate_pct
-- FROM encounters e
-- JOIN patients p
-- ON p.patient_nbr = e.patient_nbr
-- GROUP BY p.age
-- ORDER BY p.age;

-- -- 5. Readmission Rate by Gender by Descending order
-- SELECT
--     p.gender,
--     COUNT(*) AS encounters,
--     ROUND(100.0*SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/COUNT(*),1)
--     AS readmission_rate_pct
-- FROM encounters e
-- JOIN patients p
-- ON p.patient_nbr = e.patient_nbr
-- GROUP BY p.gender
-- ORDER BY readmission_rate_pct DESC;


-- -- 6. Average Length of Stay by Readmission Status
-- SELECT
--     readmitted,
--     ROUND(AVG(time_in_hospital),2) AS avg_time
-- FROM encounters
-- GROUP BY readmitted
-- ORDER BY readmitted;

-- -- 7. Top primary Diagnoses
-- SELECT
--     diag_code,
--     COUNT(*) AS total_cases
-- FROM diagnoses
-- WHERE diag_rank = 1
-- GROUP BY diag_code
-- ORDER BY total_cases DESC
-- LIMIT 10;

-- -- 8. Top 10 Medical Specialties by Number of Hospital Encounters
-- SELECT  
--     medical_specialty,
--     COUNT(*) AS total_encounters
-- FROM encounters
-- WHERE medical_specialty IS NOT NULL
--     AND medical_specialty <> ''
--     AND medical_specialty <> '?'
-- GROUP BY medical_specialty
-- ORDER BY total_encounters DESC
-- LIMIT 10;

-- -- 9. Top Diagnoses Among Readmitted Patients

-- SELECT 
--     d.diag_code,
--     COUNT(*) AS total_cases
-- FROM encounters e
-- JOIN diagnoses d
-- ON e.encounter_id = d.encounter_id
-- WHERE d.diag_rank = 1
-- AND e.readmitted <> 'NO'
-- GROUP BY d.diag_code
-- ORDER BY total_cases DESC
-- LIMIT 10;

-- -- 10. Readmission Rate by Primary Diagnosis
-- SELECT
--     d.diag_code,
--     d.diag_rank,
--     COUNT(*) AS total_cases,
--     SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_cases,
--     ROUND(100.0*SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/ COUNT(*),1)
--     AS readmission_rate
-- FROM encounters e
-- JOIN diagnoses d
-- ON e.encounter_id = d.encounter_id
-- WHERE diag_rank = 1
-- GROUP BY d.diag_code
-- ORDER BY total_cases DESC
-- LIMIT 10;

-- 11.Realiable Readmission Rate by Diagnosis
SELECT 
    diag_code,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_cases,
    ROUND(100.0*SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/COUNT(*),1) AS readmission_rate
FROM encounters e
JOIN diagnoses d 
ON e.encounter_id = d.encounter_id
WHERE d.diag_rank = 1
GROUP BY d.diag_code
HAVING COUNT(*) > 30
ORDER BY readmission_rate DESC
LIMIT 10
;
