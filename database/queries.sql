-- 1) Total encounters
SELECT COUNT(*) AS total_encouters FROM encounters;

-- 2) Total patients
SELECT COUNT(*) AS total_patients FROM patients;

-- 3) Global readmission rate
SELECT ROUND(
    100 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
    /COUNT(*),2
    ) AS readmission_rate_pct 
FROM encounters;

-- 4) Readmission by gender
SELECT
    p.gender,
    COUNT(*) AS encounters,
    ROUND(
        100 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),2
    ) AS readmission_rate_by_gender
FROM encounters e 
JOIN patients p
ON e.patient_nbr = p.patient_nbr
GROUP BY p.gender;

-- 5) Readmissionas by age group
SELECT 
    p.age,
    COUNT(*) AS encounters,
    ROUND(
        100 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),2
    ) AS readmission_rate_by_age
FROM encounters e 
JOIN patients p 
ON e.patient_nbr = p.patient_nbr
GROUP BY p.age
ORDER BY p.age;

-- 6) Average lenght of stay
SELECT 
    readmitted, 
    ROUND(AVG(time_in_hospital),2) AS avg_days
FROM encounters
GROUP BY readmitted;

-- 7) Diagnosis burden
SELECT
    number_diagnoses,
    COUNT (*) AS encounters,
    ROUND(
        100 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),2
    ) AS readmission_rate_by_burden
FROM encounters
GROUP BY number_diagnoses
ORDER BY number_diagnoses;

-- 8) Insulin usage impact
SELECT
insulin, 
COUNT(*) AS encounters,
ROUND(
    100* SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
    /COUNT(*),2
) AS readmission_rate_by_insulin
FROM encounters
GROUP BY insulin;

-- 9) Top diagnoses among readmitted
SELECT
    diag_code, 
    COUNT(*) AS total
FROM diagnoses d 
JOIN encounters e   
ON d.encounter_id = e.encounter_id
WHERE e.readmitted <> 'NO'
AND diag_rank = 1
GROUP BY diag_code
ORDER BY total DESC     
LIMIT 10;

-- 10) Risk buckets

SELECT
CASE
    WHEN number_diagnoses >= 9 THEN 'High'
    WHEN number_diagnoses BETWEEN 6 AND 8 THEN 'Medium'
ELSE 'Low'
END AS risk_group,
COUNT(*) AS encounters,
ROUND(
100.0 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
/ COUNT(*),2
) AS readmission_rate
FROM encounters
GROUP BY risk_group;

--11) Distribution by glycemic status
    SELECT
    CASE
        WHEN a1c_result = 'Norm' THEN 'Normal'
        WHEN a1c_result = '>7' THEN 'Prediabetic or Elevated'
        WHEN a1c_result = '>8' THEN 'Diabetic Poor Control'
        ELSE 'Not Measured'
    END AS glycemic_status,
    COUNT(*) AS encounters,
    ROUND(
    100.0 * COUNT(*) /
    (SELECT COUNT(*) FROM encounters),
    2
    ) AS percentage
    FROM encounters
    GROUP BY glycemic_status
    ORDER BY encounters DESC;

-- 12) readmission rate for A1C status
    SELECT
CASE
    WHEN a1c_result = 'Norm' THEN 'Normal'
    WHEN a1c_result = '>7' THEN 'Prediabetic or Elevated'
    WHEN a1c_result = '>8' THEN 'Diabetic Poor Control'
    ELSE 'Not Measured'
END AS glycemic_status,
COUNT(*) AS encounters,
ROUND(
100.0 * SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS readmission_rate
FROM encounters
GROUP BY glycemic_status
ORDER BY readmission_rate DESC;