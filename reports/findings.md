a# Clinical SQL Analytics: Diabetes Hospital Readmissions

This project explores hospital readmission patterns among diabetic patients using SQL driven analytics and an end to end clinical data workflow.

The objective is to demonstrate how structured healthcare data can be transformed into interpretable insights using relational databases, analytical SQL queries, and automated visualization.

---

## Dataset

Diabetes 130 US Hospitals Dataset  
https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999-2008

- ~101k hospital encounters
- ~71k patients
- Real world clinical records
- Publicly available healthcare dataset

---

## Project Workflow

CSV Clinical Data  
→ SQLite Relational Database  
→ SQL Analytical Queries  
→ Python Integration  
→ Interactive Visual Analytics

---

## Key Analytical Insights

### Readmission Rate by Age Group

Older patient groups present progressively higher hospital readmission rates.

![Readmission by Age](reports/readmission_age.png)

---

### Clinical Complexity and Readmission Risk

Patients with higher diagnostic burden show significantly increased readmission probability.

![Risk Groups](reports/risk_groups.png)

---

### Glycemic Control Impact

Poor glycemic control is associated with worse hospital outcomes and higher readmission rates.

![Glycemic Control](reports/glycemic_control.png)

---

## Baseline Results

| Metric | Value |
|---|---|
| Hospital encounters | 101,766 |
| Unique patients | 71,518 |
| Global readmission rate | 46% |

Detailed analytical results available in:

`reports/findings.md`

---

## Skills Demonstrated

- SQL analytics
- Relational database modeling
- Healthcare data analysis
- ETL pipeline design
- Python SQL integration
- Interactive visualization with Plotly

---

## Project Status

Baseline analytical version completed.

Future iterations will include data quality validation, feature engineering, and predictive modeling of hospital readmissions.

---

## Disclaimer

This project is intended for educational and analytical purposes only.  
All data is publicly available and de identified.