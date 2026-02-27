# Clinical Findings
## Diabetes Hospital Readmissions Analysis 
![Status](https://img.shields.io/badge/status-in%20progress-yellow)


Dataset source:
https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999-2008

This report summarizes the main analytical findings obtained through SQL based analysis over a normalized clinical database built using SQLite.

---

## 1. Dataset Overview

| Metric | Value |
|---|---|
| Total hospital encounters | 101,766 |
| Unique patients | 71,518 |
| Global readmission rate | 46.0% |

The dataset represents longitudinal hospital encounters of diabetic patients across multiple US hospitals.

---

## 2. Readmission by Gender

| Gender | Encounters | Readmission Rate (%) |
|---|---|---|
| Female | 54,708 | 46.0 |
| Male | 47,055 | 45.0 |
| Unknown / Invalid | 3 | 0.0 |

Readmission rates remain consistent across gender groups.

---

## 3. Readmission by Age Group

| Age Group | Encounters | Readmission Rate (%) |
|---|---|---|
| 0–10 | 160 | 17.0 |
| 10–20 | 670 | 36.0 |
| 20–30 | 1,628 | 44.0 |
| 30–40 | 3,719 | 41.0 |
| 40–50 | 9,485 | 43.0 |
| 50–60 | 17,034 | 43.0 |
| 60–70 | 22,380 | 46.0 |
| 70–80 | 26,050 | 48.0 |
| 80–90 | 17,625 | 49.0 |
| 90–100 | 3,015 | 44.0 |

Readmission probability increases with patient age.

---

## 4. Length of Stay

| Readmission Status | Average Days in Hospital |
|---|---|
| <30 days | 4.77 |
| >30 days | 4.50 |
| No readmission | 4.25 |

Readmitted encounters show longer hospitalization periods on average.

---

## 5. Diagnosis Burden and Clinical Complexity

| Number of Diagnoses | Encounters | Readmission Rate (%) |
|---|---|---|
| 1 | 219 | 23.0 |
| 2 | 1,023 | 32.0 |
| 3 | 2,835 | 34.0 |
| 4 | 5,537 | 37.0 |
| 5 | 11,393 | 35.0 |
| 6 | 10,161 | 43.0 |
| 7 | 10,393 | 46.0 |
| 8 | 10,616 | 47.0 |
| 9 | 49,474 | 50.0 |

Higher diagnostic burden is strongly associated with increased readmission risk.

---

## 6. Insulin Treatment Patterns

| Insulin Status | Encounters | Readmission Rate (%) |
|---|---|---|
| Down | 12,218 | 52.0 |
| Up | 11,316 | 51.0 |
| Steady | 30,849 | 45.0 |
| No | 47,383 | 43.0 |

Patients undergoing insulin dosage adjustments present higher readmission rates.

---

## 7. Top Primary Diagnoses Among Readmitted Patients

| Diagnosis Code | Total Cases |
|---|---|
| 428 | 4,057 |
| 414 | 2,720 |
| 786 | 1,709 |
| 486 | 1,683 |
| 410 | 1,438 |
| 491 | 1,360 |
| 427 | 1,226 |
| 996 | 1,035 |
| 276 | 970 |
| 682 | 957 |

Cardiovascular and respiratory related conditions appear frequently among readmitted encounters.

---

## 8. Clinical Risk Buckets

| Risk Group | Encounters | Readmission Rate (%) |
|---|---|---|
| Low | 21,007 | 35.52 |
| Medium | 31,170 | 46.06 |
| High | 49,589 | 50.58 |

Increasing clinical complexity significantly elevates readmission probability.

---

## 9. Glycemic Status Distribution (HbA1c)

| Glycemic Status | Encounters | Percentage (%) |
|---|---|---|
| Not Measured | 84,748 | 83.28 |
| Diabetic Poor Control | 8,216 | 8.07 |
| Normal | 4,990 | 4.90 |
| Prediabetic or Elevated | 3,812 | 3.75 |

Most encounters lack HbA1c measurements, reflecting real world clinical data limitations.

---

## 10. Readmission Rate by Glycemic Status

| Glycemic Status | Encounters | Readmission Rate (%) |
|---|---|---|
| Not Measured | 84,748 | 46.52 |
| Diabetic Poor Control | 8,216 | 45.18 |
| Prediabetic or Elevated | 3,812 | 44.15 |
| Normal | 4,990 | 41.70 |

Better glycemic control is associated with lower hospital readmission rates.

---

## Baseline Summary

This baseline analysis demonstrates how SQL driven analytics applied to a normalized clinical database can uncover meaningful healthcare patterns related to hospital readmissions.

The project establishes a reproducible analytical workflow integrating relational modeling, ETL processes, and automated visualization.