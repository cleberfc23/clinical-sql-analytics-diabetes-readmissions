# Clinical SQL Analytics — Diabetes Hospital Readmissions

![Status](https://img.shields.io/badge/status-baseline%20complete-blue?style=for-the-badge)

SQL-driven analytics pipeline for hospital readmission patterns in diabetic patients.
Covers relational data modeling, ETL, analytical queries, and interactive visualization
across 101,766 encounters from 71,518 patients.

**Dataset:** [Diabetes 130-US Hospitals](https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999-2008)
(UCI ML Repository) — real-world clinical records, publicly available and de-identified.

---

## Pipeline
```
CSV Clinical Data → SQLite relational model → SQL analytical queries
                                                      ↓
                                          Python integration (Pandas)
                                                      ↓
                                      Interactive visualization (Plotly)
```

---

## Results

| Metric                        | Value          |
|-------------------------------|----------------|
| Hospital encounters           | 101,766        |
| Unique patients               | 71,518         |
| Global readmission rate       | 46%            |
| Low-risk group readmission    | 35.52%         |
| High-risk group readmission   | 50.58%         |

→ [Full findings report — Baseline v1.0](/reports/findings.md)

---

## Key Findings

### Readmission Rate by Age Group
Older patient groups show progressively higher readmission rates across all cohorts.

![Readmission by Age](/reports/readmission_age.png)

### Clinical Complexity and Readmission Risk
Patients with higher diagnostic burden present significantly increased readmission
probability — risk buckets derived from composite clinical features.

![Risk Groups](/reports/readmission_clinical_risk_group.png)

### Glycemic Control Impact
Poor glycemic control correlates with higher readmission rates across patient segments.

![Glycemic Control](/reports/readmission_rate_glycemic_control.png)

---

## Tech Stack

SQL · SQLite · Python · Pandas · Plotly

---

## Baseline complete — next phase planned

Baseline analytics complete: relational modeling, ETL pipeline, SQL analysis,
risk stratification, and visualization implemented.

Next phase (not yet started): data quality validation, feature engineering,
and predictive modeling of readmission risk.

---

## Disclaimer

Engineering and research project — not medical advice.
All data is publicly available and de-identified.

---

## Author

[Cleber F. Carvalho](https://github.com/cleberfc23)
