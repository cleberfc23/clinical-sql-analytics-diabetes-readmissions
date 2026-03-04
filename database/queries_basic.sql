-- 1. Dataset sanity check
SELECT  COUNT(*) AS total_encounters,
        COUNT(DISTINCT patient_nbr) AS unique_patients,
        ROUND(100*SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)/COUNT(*),1) AS readmission_rate_pct
FROM encounters